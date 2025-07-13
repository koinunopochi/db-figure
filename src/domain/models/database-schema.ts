import { Table } from './table.js';
import { TableGroup } from './table-group.js';

export class DatabaseSchema {
  private readonly _tables: Map<string, Table>;

  constructor(
    readonly name: string,
    tables: Table[] = [],
  ) {
    if (!name) {
      throw new Error('Database name is required');
    }

    this._tables = new Map(tables.map(table => [table.name, table]));
  }

  get tables(): Table[] {
    return Array.from(this._tables.values());
  }

  addTable(table: Table): void {
    if (this._tables.has(table.name)) {
      throw new Error(`Table ${table.name} already exists in database ${this.name}`);
    }
    this._tables.set(table.name, table);
  }

  getTable(name: string): Table | undefined {
    return this._tables.get(name);
  }

  getRelatedTables(tableName: string): Table[] {
    const table = this.getTable(tableName);
    if (!table) return [];

    const related = new Set<Table>();

    // Tables referenced by this table
    table.foreignKeys.forEach(fk => {
      const referencedTable = this.getTable(fk.referencedTableName);
      if (referencedTable) {
        related.add(referencedTable);
      }
    });

    // Tables that reference this table
    this.tables.forEach(t => {
      if (t.hasRelationTo(tableName)) {
        related.add(t);
      }
    });

    return Array.from(related);
  }

  validateRelations(): string[] {
    const errors: string[] = [];

    this.tables.forEach(table => {
      table.foreignKeys.forEach(fk => {
        const referencedTable = this.getTable(fk.referencedTableName);
        if (!referencedTable) {
          errors.push(`Table ${table.name}: Foreign key ${fk.name} references non-existent table ${fk.referencedTableName}`);
        } else {
          const referencedColumn = referencedTable.getColumn(fk.referencedColumnName);
          if (!referencedColumn) {
            errors.push(`Table ${table.name}: Foreign key ${fk.name} references non-existent column ${fk.referencedColumnName} in table ${fk.referencedTableName}`);
          }
        }
      });
    });

    return errors;
  }

  groupTablesByRelations(maxTablesPerGroup: number = 20): TableGroup[] {
    const groups: TableGroup[] = [];
    const processedTables = new Set<string>();
    const tablesCopy = [...this.tables];

    // Start with tables that have the most relationships
    tablesCopy.sort((a, b) => {
      const aRelations = a.foreignKeys.length + this.getReferencingTables(a.name).length;
      const bRelations = b.foreignKeys.length + this.getReferencingTables(b.name).length;
      return bRelations - aRelations;
    });

    for (const table of tablesCopy) {
      if (processedTables.has(table.name)) continue;

      // Create a new group starting with this table
      const groupTables: Table[] = [table];
      processedTables.add(table.name);

      // Add related tables up to the limit
      const relatedTables = this.getRelatedTablesRecursive(table, processedTables, maxTablesPerGroup - 1);
      relatedTables.forEach(t => {
        if (groupTables.length < maxTablesPerGroup && !processedTables.has(t.name)) {
          groupTables.push(t);
          processedTables.add(t.name);
        }
      });

      if (groupTables.length > 0) {
        const groupName = `Group ${groups.length + 1}: ${table.name} and related`;
        groups.push(new TableGroup(groupName, groupTables));
      }
    }

    // Handle any remaining tables
    const remainingTables = this.tables.filter(t => !processedTables.has(t.name));
    if (remainingTables.length > 0) {
      for (let i = 0; i < remainingTables.length; i += maxTablesPerGroup) {
        const groupTables = remainingTables.slice(i, i + maxTablesPerGroup);
        const groupName = `Group ${groups.length + 1}: Other tables`;
        groups.push(new TableGroup(groupName, groupTables));
      }
    }

    return groups;
  }

  private getRelatedTablesRecursive(table: Table, processedTables: Set<string>, maxDepth: number, currentDepth: number = 0): Table[] {
    if (currentDepth >= maxDepth) return [];

    const related: Table[] = [];
    const directlyRelated = this.getRelatedTables(table.name);

    for (const relatedTable of directlyRelated) {
      if (!processedTables.has(relatedTable.name)) {
        related.push(relatedTable);
        // Recursively get related tables
        const indirectlyRelated = this.getRelatedTablesRecursive(relatedTable, processedTables, maxDepth, currentDepth + 1);
        related.push(...indirectlyRelated.filter(t => !related.some(r => r.name === t.name)));
      }
    }

    return related;
  }

  private getReferencingTables(tableName: string): Table[] {
    return this.tables.filter(table => table.hasRelationTo(tableName));
  }
}