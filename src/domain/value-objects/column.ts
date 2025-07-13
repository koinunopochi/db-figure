export type ColumnType = 
  | 'int' 
  | 'bigint' 
  | 'varchar' 
  | 'char' 
  | 'text' 
  | 'datetime' 
  | 'timestamp' 
  | 'date' 
  | 'boolean' 
  | 'decimal' 
  | 'float' 
  | 'double'
  | 'json'
  | 'blob'
  | 'enum'
  | 'set'
  | 'other';

export class Column {
  constructor(
    readonly name: string,
    readonly type: ColumnType,
    readonly nullable: boolean,
    readonly primaryKey: boolean,
    readonly autoIncrement: boolean,
    readonly defaultValue?: string,
    readonly length?: number,
    readonly comment?: string,
  ) {
    if (!name) {
      throw new Error('Column name is required');
    }
  }

  static create(params: {
    name: string;
    type: string;
    nullable?: boolean;
    primaryKey?: boolean;
    autoIncrement?: boolean;
    defaultValue?: string;
    length?: number;
    comment?: string;
  }): Column {
    return new Column(
      params.name,
      this.normalizeType(params.type),
      params.nullable ?? true,
      params.primaryKey ?? false,
      params.autoIncrement ?? false,
      params.defaultValue,
      params.length,
      params.comment,
    );
  }

  private static normalizeType(type: string): ColumnType {
    const normalized = type.toLowerCase();
    
    if (normalized.includes('int')) return 'int';
    if (normalized.includes('bigint')) return 'bigint';
    if (normalized.includes('varchar')) return 'varchar';
    if (normalized.includes('char')) return 'char';
    if (normalized.includes('text')) return 'text';
    if (normalized.includes('datetime')) return 'datetime';
    if (normalized.includes('timestamp')) return 'timestamp';
    if (normalized.includes('date')) return 'date';
    if (normalized.includes('bool')) return 'boolean';
    if (normalized.includes('decimal') || normalized.includes('numeric')) return 'decimal';
    if (normalized.includes('float')) return 'float';
    if (normalized.includes('double')) return 'double';
    if (normalized.includes('json')) return 'json';
    if (normalized.includes('blob')) return 'blob';
    if (normalized.includes('enum')) return 'enum';
    if (normalized.includes('set')) return 'set';
    
    return 'other';
  }
}