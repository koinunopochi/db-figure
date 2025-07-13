import { Table } from './table.js';

export class TableGroup {
  constructor(
    readonly name: string,
    readonly tables: Table[],
    readonly description?: string,
  ) {
    if (!name) {
      throw new Error('TableGroup name is required');
    }
    if (!tables.length) {
      throw new Error('TableGroup must contain at least one table');
    }
  }

  hasTable(tableName: string): boolean {
    return this.tables.some(table => table.name === tableName);
  }

  getTableNames(): string[] {
    return this.tables.map(table => table.name);
  }

  getRelatedTables(): Table[] {
    const relatedSet = new Set<Table>();

    this.tables.forEach(table => {
      // Add tables that this group's tables reference
      table.foreignKeys.forEach(fk => {
        const referencedTable = this.tables.find(t => t.name === fk.referencedTableName);
        if (referencedTable) {
          relatedSet.add(referencedTable);
        }
      });

      // Add tables that reference this group's tables
      this.tables.forEach(otherTable => {
        if (otherTable.hasRelationTo(table.name)) {
          relatedSet.add(otherTable);
        }
      });
    });

    return Array.from(relatedSet);
  }
}