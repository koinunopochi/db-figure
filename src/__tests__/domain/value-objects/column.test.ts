import { describe, it, expect } from 'vitest';
import { Column } from '../../../domain/value-objects/column.js';

describe('Column', () => {
  describe('constructor', () => {
    it('should create a column with required properties', () => {
      // Given
      const name = 'id';
      const type = 'int';

      // When
      const column = new Column(name, type, false, true, true);

      // Then
      expect(column.name).toBe(name);
      expect(column.type).toBe(type);
      expect(column.nullable).toBe(false);
      expect(column.primaryKey).toBe(true);
      expect(column.autoIncrement).toBe(true);
    });

    it('should throw error when name is empty', () => {
      // Given
      const name = '';
      const type = 'int';

      // When/Then
      expect(() => new Column(name, type, false, false, false)).toThrow('Column name is required');
    });
  });

  describe('create', () => {
    it('should create column with default values', () => {
      // Given
      const params = { name: 'created_at', type: 'timestamp' };

      // When
      const column = Column.create(params);

      // Then
      expect(column.name).toBe('created_at');
      expect(column.type).toBe('timestamp');
      expect(column.nullable).toBe(true);
      expect(column.primaryKey).toBe(false);
      expect(column.autoIncrement).toBe(false);
    });

    it('should normalize various int types', () => {
      // Given
      const types = ['INT', 'INTEGER', 'TINYINT', 'SMALLINT', 'MEDIUMINT'];

      // When/Then
      types.forEach(type => {
        const column = Column.create({ name: 'test', type });
        expect(column.type).toBe('int');
      });
    });

    it('should normalize varchar types', () => {
      // Given
      const types = ['VARCHAR(255)', 'varchar', 'VARCHAR'];

      // When/Then
      types.forEach(type => {
        const column = Column.create({ name: 'test', type });
        expect(column.type).toBe('varchar');
      });
    });

    it('should handle unknown types as other', () => {
      // Given
      const column = Column.create({ name: 'test', type: 'CUSTOM_TYPE' });

      // When/Then
      expect(column.type).toBe('other');
    });
  });
});