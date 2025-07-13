import { SqlParserRepository } from '../../domain/repositories/sql-parser.repository.js';
import { DatabaseSchema } from '../../domain/models/database-schema.js';
import { Table } from '../../domain/models/table.js';
import { Column } from '../../domain/value-objects/column.js';
import { ForeignKey } from '../../domain/value-objects/foreign-key.js';
import { Index } from '../../domain/value-objects/index.js';

export class SimpleSqlParserAdapter implements SqlParserRepository {
  async parse(sqlContent: string): Promise<DatabaseSchema> {
    // Extract database name from USE statement or default
    const databaseName = this.extractDatabaseName(sqlContent) || 'database';
    const schema = new DatabaseSchema(databaseName);

    // Find all CREATE TABLE statements
    const createTableRegex = /CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?`?([\w-]+)`?\s*\(([\s\S]*?)\)(?:\s*ENGINE[\s\S]*?)?;/gi;
    let match;

    while ((match = createTableRegex.exec(sqlContent)) !== null) {
      const tableName = match[1];
      const tableContent = match[2];
      
      const table = this.parseTable(tableName, tableContent);
      schema.addTable(table);
    }

    // Process ALTER TABLE for foreign keys
    const alterTableRegex = /ALTER\s+TABLE\s+`?([\w-]+)`?\s+ADD\s+(?:CONSTRAINT\s+`?([\w-]+)`?\s+)?FOREIGN\s+KEY\s*\(`?([\w-]+)`?\)\s*REFERENCES\s+`?([\w-]+)`?\s*\(`?([\w-]+)`?\)([^;]*);/gi;
    
    while ((match = alterTableRegex.exec(sqlContent)) !== null) {
      const tableName = match[1];
      const constraintName = match[2] || `fk_${tableName}_${match[3]}`;
      const columnName = match[3];
      const referencedTable = match[4];
      const referencedColumn = match[5];
      const actions = match[6];

      const table = schema.getTable(tableName);
      if (table) {
        const fk = this.parseForeignKeyActions(constraintName, columnName, referencedTable, referencedColumn, actions);
        table.addForeignKey(fk);
      }
    }

    return schema;
  }

  private extractDatabaseName(sqlContent: string): string | null {
    const useMatch = sqlContent.match(/USE\s+`?([\w-]+)`?/i);
    if (useMatch) {
      return useMatch[1];
    }

    const createDbMatch = sqlContent.match(/CREATE\s+DATABASE.*?`?([\w-]+)`?/i);
    if (createDbMatch) {
      return createDbMatch[1];
    }

    return null;
  }

  private parseTable(tableName: string, content: string): Table {
    const table = new Table(tableName);
    
    // Split by commas but respect parentheses
    const parts = this.splitTableContent(content);
    
    for (const part of parts) {
      const trimmed = part.trim();
      
      if (!trimmed) continue;
      
      // Check if it's a constraint
      if (/^(PRIMARY\s+KEY|FOREIGN\s+KEY|KEY|INDEX|UNIQUE|CONSTRAINT)/i.test(trimmed)) {
        this.parseConstraint(trimmed, table);
      } else {
        // It's a column
        const column = this.parseColumn(trimmed);
        if (column) {
          table.addColumn(column);
        }
      }
    }
    
    return table;
  }

  private splitTableContent(content: string): string[] {
    const parts: string[] = [];
    let current = '';
    let depth = 0;
    
    for (let i = 0; i < content.length; i++) {
      const char = content[i];
      
      if (char === '(') {
        depth++;
      } else if (char === ')') {
        depth--;
      } else if (char === ',' && depth === 0) {
        parts.push(current);
        current = '';
        continue;
      }
      
      current += char;
    }
    
    if (current.trim()) {
      parts.push(current);
    }
    
    return parts;
  }

  private parseColumn(definition: string): Column | null {
    // Basic regex to parse column definition
    const match = definition.match(/^`?([\w-]+)`?\s+(\w+)(?:\((\d+)(?:,\d+)?\))?(.*)/);
    if (!match) return null;
    
    const name = match[1];
    const type = match[2];
    const length = match[3] ? parseInt(match[3]) : undefined;
    const rest = match[4] || '';
    
    const nullable = !/NOT\s+NULL/i.test(rest);
    const autoIncrement = /AUTO_INCREMENT/i.test(rest);
    const primaryKey = /PRIMARY\s+KEY/i.test(rest);
    
    let defaultValue: string | undefined;
    const defaultMatch = rest.match(/DEFAULT\s+([^\s,]+)/i);
    if (defaultMatch) {
      defaultValue = defaultMatch[1].replace(/['"`]/g, '');
    }
    
    let comment: string | undefined;
    const commentMatch = rest.match(/COMMENT\s+['"]([^'"]+)['"]/i);
    if (commentMatch) {
      comment = commentMatch[1];
    }
    
    return Column.create({
      name,
      type,
      nullable,
      primaryKey,
      autoIncrement,
      defaultValue,
      length,
      comment,
    });
  }

  private parseConstraint(definition: string, table: Table): void {
    // PRIMARY KEY
    if (/^PRIMARY\s+KEY/i.test(definition)) {
      const match = definition.match(/\(([^)]+)\)/);
      if (match) {
        const columns = match[1].split(',').map(c => c.trim().replace(/[`'"]/g, ''));
        table.addIndex(Index.create({
          name: 'PRIMARY',
          columns,
          type: 'PRIMARY',
        }));
      }
    }
    
    // FOREIGN KEY
    const fkMatch = definition.match(/(?:CONSTRAINT\s+`?([\w-]+)`?\s+)?FOREIGN\s+KEY\s*\(`?([\w-]+)`?\)\s*REFERENCES\s+`?([\w-]+)`?\s*\(`?([\w-]+)`?\)(.*)/);
    if (fkMatch) {
      const constraintName = fkMatch[1] || `fk_${table.name}_${fkMatch[2]}`;
      const columnName = fkMatch[2];
      const referencedTable = fkMatch[3];
      const referencedColumn = fkMatch[4];
      const actions = fkMatch[5];
      
      const fk = this.parseForeignKeyActions(constraintName, columnName, referencedTable, referencedColumn, actions);
      table.addForeignKey(fk);
    }
    
    // INDEX/KEY
    const indexMatch = definition.match(/^(INDEX|KEY|UNIQUE)\s+`?([\w-]+)`?\s*\(([^)]+)\)/);
    if (indexMatch) {
      const type = indexMatch[1];
      const name = indexMatch[2];
      const columns = indexMatch[3].split(',').map(c => c.trim().replace(/[`'"]/g, ''));
      
      table.addIndex(Index.create({
        name,
        columns,
        type,
      }));
    }
  }

  private parseForeignKeyActions(
    name: string,
    columnName: string,
    referencedTable: string,
    referencedColumn: string,
    actions: string
  ): ForeignKey {
    let onDelete: string | undefined;
    let onUpdate: string | undefined;
    
    if (actions) {
      const onDeleteMatch = actions.match(/ON\s+DELETE\s+(CASCADE|SET\s+NULL|RESTRICT|NO\s+ACTION)/i);
      if (onDeleteMatch) {
        onDelete = onDeleteMatch[1];
      }
      
      const onUpdateMatch = actions.match(/ON\s+UPDATE\s+(CASCADE|SET\s+NULL|RESTRICT|NO\s+ACTION)/i);
      if (onUpdateMatch) {
        onUpdate = onUpdateMatch[1];
      }
    }
    
    return ForeignKey.create({
      name,
      columnName,
      referencedTableName: referencedTable,
      referencedColumnName: referencedColumn,
      onDelete,
      onUpdate,
    });
  }
}