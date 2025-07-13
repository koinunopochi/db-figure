import { Column } from '../value-objects/column.js';
import { ForeignKey } from '../value-objects/foreign-key.js';
import { Index } from '../value-objects/index.js';

export class Table {
  private readonly _columns: Map<string, Column>;
  private readonly _foreignKeys: Map<string, ForeignKey>;
  private readonly _indexes: Map<string, Index>;

  constructor(
    readonly name: string,
    columns: Column[] = [],
    foreignKeys: ForeignKey[] = [],
    indexes: Index[] = [],
    readonly comment?: string,
  ) {
    if (!name) {
      throw new Error('Table name is required');
    }

    this._columns = new Map(columns.map(col => [col.name, col]));
    this._foreignKeys = new Map(foreignKeys.map(fk => [fk.name, fk]));
    this._indexes = new Map(indexes.map(idx => [idx.name, idx]));
  }

  get columns(): Column[] {
    return Array.from(this._columns.values());
  }

  get foreignKeys(): ForeignKey[] {
    return Array.from(this._foreignKeys.values());
  }

  get indexes(): Index[] {
    return Array.from(this._indexes.values());
  }

  get primaryKey(): Column | undefined {
    return this.columns.find(col => col.primaryKey);
  }

  addColumn(column: Column): void {
    if (this._columns.has(column.name)) {
      throw new Error(`Column ${column.name} already exists in table ${this.name}`);
    }
    this._columns.set(column.name, column);
  }

  addForeignKey(foreignKey: ForeignKey): void {
    if (this._foreignKeys.has(foreignKey.name)) {
      throw new Error(`Foreign key ${foreignKey.name} already exists in table ${this.name}`);
    }
    this._foreignKeys.set(foreignKey.name, foreignKey);
  }

  addIndex(index: Index): void {
    if (this._indexes.has(index.name)) {
      throw new Error(`Index ${index.name} already exists in table ${this.name}`);
    }
    this._indexes.set(index.name, index);
  }

  getColumn(name: string): Column | undefined {
    return this._columns.get(name);
  }

  hasRelationTo(tableName: string): boolean {
    return this.foreignKeys.some(fk => fk.referencedTableName === tableName);
  }
}