import { MermaidGeneratorAdapter } from './mermaid-generator.adapter.js';
import { DatabaseSchema } from '../../domain/models/database-schema.js';
import { TableGroup } from '../../domain/models/table-group.js';
import { Table } from '../../domain/models/table.js';
import { ForeignKey } from '../../domain/value-objects/foreign-key.js';

export interface GroupedDiagramOptions {
  maxTablesPerDiagram?: number;
  includeOrphanTables?: boolean;
}

export class MermaidGroupedGeneratorAdapter extends MermaidGeneratorAdapter {
  generateGrouped(schema: DatabaseSchema, options: GroupedDiagramOptions = {}): Map<string, string> {
    const maxTablesPerDiagram = options.maxTablesPerDiagram || 20;
    const groups = schema.groupTablesByRelations(maxTablesPerDiagram);
    const diagrams = new Map<string, string>();

    groups.forEach((group, index) => {
      const diagram = this.generateGroupDiagram(group, schema);
      diagrams.set(group.name, diagram);
    });

    return diagrams;
  }

  private generateGroupDiagram(group: TableGroup, schema: DatabaseSchema): string {
    const lines: string[] = [];
    
    // Start Mermaid ER diagram
    lines.push('```mermaid');
    lines.push('erDiagram');
    lines.push('');

    // Generate table definitions for this group
    group.tables.forEach(table => {
      lines.push(...this.generateTableDefinition(table));
    });

    // Add space before relationships
    if (this.hasRelationshipsInGroup(group, schema)) {
      lines.push('');
    }

    // Generate relationships only between tables in this group
    group.tables.forEach(table => {
      lines.push(...this.generateGroupRelationships(table, group));
    });

    lines.push('```');
    
    return lines.join('\n');
  }


  private generateGroupRelationships(table: Table, group: TableGroup): string[] {
    const lines: string[] = [];
    const indent = '    ';

    table.foreignKeys.forEach(fk => {
      // Only include relationships where both tables are in the group
      if (group.hasTable(fk.referencedTableName)) {
        const relationship = super.generateRelationship(table, fk);
        lines.push(`${indent}${relationship}`);
      }
    });

    return lines;
  }


  private hasRelationshipsInGroup(group: TableGroup, schema: DatabaseSchema): boolean {
    return group.tables.some(table => 
      table.foreignKeys.some(fk => group.hasTable(fk.referencedTableName))
    );
  }

}