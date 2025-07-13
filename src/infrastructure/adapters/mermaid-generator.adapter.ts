import { DiagramGeneratorRepository } from '../../domain/repositories/diagram-generator.repository.js';
import { DatabaseSchema } from '../../domain/models/database-schema.js';
import { Table } from '../../domain/models/table.js';
import { Column } from '../../domain/value-objects/column.js';
import { ForeignKey } from '../../domain/value-objects/foreign-key.js';

export class MermaidGeneratorAdapter implements DiagramGeneratorRepository {
  generate(schema: DatabaseSchema): string {
    const lines: string[] = [];
    
    // Start Mermaid ER diagram
    lines.push('```mermaid');
    lines.push('erDiagram');
    lines.push('');

    // Generate table definitions
    schema.tables.forEach(table => {
      lines.push(...this.generateTableDefinition(table));
    });

    // Add space before relationships
    if (this.hasRelationships(schema)) {
      lines.push('');
    }

    // Generate relationships
    schema.tables.forEach(table => {
      lines.push(...this.generateRelationships(table));
    });

    lines.push('```');
    
    return lines.join('\n');
  }

  protected generateTableDefinition(table: Table): string[] {
    const lines: string[] = [];
    const indent = '    ';

    lines.push(`${indent}${this.escapeTableName(table.name)} {`);

    table.columns.forEach(column => {
      const columnDef = this.generateColumnDefinition(column);
      lines.push(`${indent}${indent}${columnDef}`);
    });

    lines.push(`${indent}}`);
    lines.push('');

    return lines;
  }

  protected generateColumnDefinition(column: Column): string {
    const parts: string[] = [];

    // Column type mapping to Mermaid types
    const mermaidType = this.mapToMermaidType(column.type);
    parts.push(mermaidType);

    // Column name
    parts.push(this.escapeColumnName(column.name));

    // Combine constraints and comment into a single quoted string
    const attributes: string[] = [];
    
    // Add constraints
    if (column.primaryKey) attributes.push('PK');
    if (column.autoIncrement) attributes.push('AI');
    if (!column.nullable) attributes.push('NOT NULL');
    
    // Add comment
    if (column.comment) {
      // If there are constraints, add separator
      if (attributes.length > 0) {
        attributes.push(`| ${column.comment}`);
      } else {
        attributes.push(column.comment);
      }
    }

    // Only add the attribute string if there are any attributes
    if (attributes.length > 0) {
      parts.push(`"${attributes.join(' ')}"`);
    }

    return parts.join(' ');
  }

  protected generateRelationships(table: Table): string[] {
    const lines: string[] = [];
    const indent = '    ';

    table.foreignKeys.forEach(fk => {
      const relationship = this.generateRelationship(table, fk);
      lines.push(`${indent}${relationship}`);
    });

    return lines;
  }

  protected generateRelationship(table: Table, fk: ForeignKey): string {
    // Determine cardinality based on nullability and other factors
    const sourceCardinality = this.determineSourceCardinality(table, fk);
    const targetCardinality = '||'; // One

    // Format: parent ||--o{ child : relationship_name
    return `${this.escapeTableName(fk.referencedTableName)} ${targetCardinality}--${sourceCardinality} ${this.escapeTableName(table.name)} : "${fk.name}"`;
  }

  protected determineSourceCardinality(table: Table, fk: ForeignKey): string {
    const column = table.getColumn(fk.columnName);
    
    if (!column) return 'o{'; // Zero or more (default)

    // If the foreign key column is nullable, it's zero or more
    if (column.nullable) {
      return 'o{'; // Zero or more
    }

    // If not nullable, it's one or more
    return '|{'; // One or more
  }

  protected mapToMermaidType(columnType: string): string {
    const typeMap: Record<string, string> = {
      'int': 'int',
      'bigint': 'bigint',
      'varchar': 'string',
      'char': 'string',
      'text': 'string',
      'datetime': 'datetime',
      'timestamp': 'timestamp',
      'date': 'date',
      'boolean': 'boolean',
      'decimal': 'decimal',
      'float': 'float',
      'double': 'double',
      'json': 'json',
      'blob': 'blob',
      'enum': 'enum',
      'set': 'set',
      'other': 'string',
    };

    return typeMap[columnType] || 'string';
  }

  protected escapeTableName(name: string): string {
    // Escape special characters in table names
    if (/[^a-zA-Z0-9_]/.test(name)) {
      return `"${name}"`;
    }
    return name;
  }

  protected escapeColumnName(name: string): string {
    // Escape special characters in column names
    if (/[^a-zA-Z0-9_]/.test(name)) {
      return `"${name}"`;
    }
    return name;
  }

  protected hasRelationships(schema: DatabaseSchema): boolean {
    return schema.tables.some(table => table.foreignKeys.length > 0);
  }
}