import { describe, it, expect, beforeEach } from 'vitest';
import { Table } from '../../../domain/models/table.js';
import { Column } from '../../../domain/value-objects/column.js';
import { ForeignKey } from '../../../domain/value-objects/foreign-key.js';
import { Index } from '../../../domain/value-objects/index.js';

describe('Table', () => {
  let idColumn: Column;
  let nameColumn: Column;

  beforeEach(() => {
    idColumn = Column.create({ name: 'id', type: 'int', primaryKey: true, autoIncrement: true, nullable: false });
    nameColumn = Column.create({ name: 'name', type: 'varchar', length: 255 });
  });

  describe('constructor', () => {
    it('should create a table with required properties', () => {
      // Given
      const tableName = 'users';

      // When
      const table = new Table(tableName);

      // Then
      expect(table.name).toBe(tableName);
      expect(table.columns).toEqual([]);
      expect(table.foreignKeys).toEqual([]);
      expect(table.indexes).toEqual([]);
    });

    it('should throw error when name is empty', () => {
      // Given
      const tableName = '';

      // When/Then
      expect(() => new Table(tableName)).toThrow('Table name is required');
    });

    it('should create a table with columns, foreign keys and indexes', () => {
      // Given
      const fk = ForeignKey.create({
        name: 'fk_user_role',
        columnName: 'role_id',
        referencedTableName: 'roles',
        referencedColumnName: 'id',
      });
      const index = Index.create({
        name: 'idx_name',
        columns: ['name'],
      });

      // When
      const table = new Table('users', [idColumn, nameColumn], [fk], [index], 'User table');

      // Then
      expect(table.columns).toHaveLength(2);
      expect(table.foreignKeys).toHaveLength(1);
      expect(table.indexes).toHaveLength(1);
      expect(table.comment).toBe('User table');
    });
  });

  describe('addColumn', () => {
    it('should add a column to the table', () => {
      // Given
      const table = new Table('users');

      // When
      table.addColumn(idColumn);

      // Then
      expect(table.columns).toHaveLength(1);
      expect(table.getColumn('id')).toBe(idColumn);
    });

    it('should throw error when adding duplicate column', () => {
      // Given
      const table = new Table('users', [idColumn]);

      // When/Then
      expect(() => table.addColumn(idColumn)).toThrow('Column id already exists in table users');
    });
  });

  describe('primaryKey', () => {
    it('should return primary key column', () => {
      // Given
      const table = new Table('users', [idColumn, nameColumn]);

      // When
      const pk = table.primaryKey;

      // Then
      expect(pk).toBe(idColumn);
    });

    it('should return undefined when no primary key', () => {
      // Given
      const table = new Table('users', [nameColumn]);

      // When
      const pk = table.primaryKey;

      // Then
      expect(pk).toBeUndefined();
    });
  });

  describe('hasRelationTo', () => {
    it('should return true when table has foreign key to specified table', () => {
      // Given
      const fk = ForeignKey.create({
        name: 'fk_user_role',
        columnName: 'role_id',
        referencedTableName: 'roles',
        referencedColumnName: 'id',
      });
      const table = new Table('users', [], [fk]);

      // When
      const hasRelation = table.hasRelationTo('roles');

      // Then
      expect(hasRelation).toBe(true);
    });

    it('should return false when table has no foreign key to specified table', () => {
      // Given
      const table = new Table('users');

      // When
      const hasRelation = table.hasRelationTo('roles');

      // Then
      expect(hasRelation).toBe(false);
    });
  });
});