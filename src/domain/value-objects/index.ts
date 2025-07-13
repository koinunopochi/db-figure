export type IndexType = 'PRIMARY' | 'UNIQUE' | 'INDEX' | 'FULLTEXT' | 'SPATIAL';

export class Index {
  constructor(
    readonly name: string,
    readonly columns: string[],
    readonly type: IndexType,
  ) {
    if (!name || !columns.length) {
      throw new Error('Index requires name and at least one column');
    }
  }

  static create(params: {
    name: string;
    columns: string[];
    type?: string;
  }): Index {
    return new Index(
      params.name,
      params.columns,
      this.normalizeType(params.type),
    );
  }

  private static normalizeType(type?: string): IndexType {
    if (!type) return 'INDEX';
    
    const normalized = type.toUpperCase();
    if (normalized.includes('PRIMARY')) return 'PRIMARY';
    if (normalized.includes('UNIQUE')) return 'UNIQUE';
    if (normalized.includes('FULLTEXT')) return 'FULLTEXT';
    if (normalized.includes('SPATIAL')) return 'SPATIAL';
    
    return 'INDEX';
  }
}