export class ForeignKey {
  constructor(
    readonly name: string,
    readonly columnName: string,
    readonly referencedTableName: string,
    readonly referencedColumnName: string,
    readonly onDelete?: 'CASCADE' | 'SET NULL' | 'RESTRICT' | 'NO ACTION',
    readonly onUpdate?: 'CASCADE' | 'SET NULL' | 'RESTRICT' | 'NO ACTION',
  ) {
    if (!columnName || !referencedTableName || !referencedColumnName) {
      throw new Error('Foreign key requires column name, referenced table and column');
    }
  }

  static create(params: {
    name: string;
    columnName: string;
    referencedTableName: string;
    referencedColumnName: string;
    onDelete?: string;
    onUpdate?: string;
  }): ForeignKey {
    return new ForeignKey(
      params.name,
      params.columnName,
      params.referencedTableName,
      params.referencedColumnName,
      this.normalizeAction(params.onDelete),
      this.normalizeAction(params.onUpdate),
    );
  }

  private static normalizeAction(action?: string): 'CASCADE' | 'SET NULL' | 'RESTRICT' | 'NO ACTION' | undefined {
    if (!action) return undefined;
    
    const normalized = action.toUpperCase();
    if (normalized === 'CASCADE') return 'CASCADE';
    if (normalized === 'SET NULL') return 'SET NULL';
    if (normalized === 'RESTRICT') return 'RESTRICT';
    if (normalized === 'NO ACTION') return 'NO ACTION';
    
    return undefined;
  }
}