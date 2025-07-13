import { describe, it, expect } from 'vitest';
import { MermaidGeneratorAdapter } from '../../../infrastructure/adapters/mermaid-generator.adapter.js';
import { DatabaseSchema } from '../../../domain/models/database-schema.js';
import { Table } from '../../../domain/models/table.js';
import { Column } from '../../../domain/value-objects/column.js';
import { ForeignKey } from '../../../domain/value-objects/foreign-key.js';

describe('MermaidGeneratorAdapter', () => {
  const generator = new MermaidGeneratorAdapter();

  describe('generate', () => {
    it('should generate a simple table without relationships', () => {
      // Given
      const schema = new DatabaseSchema('testdb');
      const table = new Table('users', [
        Column.create({ name: 'id', type: 'int', primaryKey: true, autoIncrement: true, nullable: false }),
        Column.create({ name: 'name', type: 'varchar', length: 255, nullable: false }),
        Column.create({ name: 'email', type: 'varchar', length: 255 }),
      ]);
      schema.addTable(table);

      // When
      const result = generator.generate(schema);

      // Then
      expect(result).toContain('```mermaid');
      expect(result).toContain('erDiagram');
      expect(result).toContain('users {');
      expect(result).toContain('int id "PK AI NOT NULL"');
      expect(result).toContain('string name "NOT NULL"');
      expect(result).toContain('string email');
      expect(result).toContain('```');
    });

    it('should generate tables with foreign key relationships', () => {
      // Given
      const schema = new DatabaseSchema('testdb');
      
      const usersTable = new Table('users', [
        Column.create({ name: 'id', type: 'int', primaryKey: true }),
      ]);
      
      const postsTable = new Table('posts', [
        Column.create({ name: 'id', type: 'int', primaryKey: true }),
        Column.create({ name: 'user_id', type: 'int', nullable: false }),
      ], [
        ForeignKey.create({
          name: 'fk_posts_user',
          columnName: 'user_id',
          referencedTableName: 'users',
          referencedColumnName: 'id',
        }),
      ]);

      schema.addTable(usersTable);
      schema.addTable(postsTable);

      // When
      const result = generator.generate(schema);

      // Then
      expect(result).toContain('users ||--|{ posts : "fk_posts_user"');
    });

    it('should handle nullable foreign keys with correct cardinality', () => {
      // Given
      const schema = new DatabaseSchema('testdb');
      
      const categoriesTable = new Table('categories', [
        Column.create({ name: 'id', type: 'int', primaryKey: true }),
      ]);
      
      const productsTable = new Table('products', [
        Column.create({ name: 'id', type: 'int', primaryKey: true }),
        Column.create({ name: 'category_id', type: 'int', nullable: true }),
      ], [
        ForeignKey.create({
          name: 'fk_products_category',
          columnName: 'category_id',
          referencedTableName: 'categories',
          referencedColumnName: 'id',
        }),
      ]);

      schema.addTable(categoriesTable);
      schema.addTable(productsTable);

      // When
      const result = generator.generate(schema);

      // Then
      expect(result).toContain('categories ||--o{ products : "fk_products_category"');
    });

    it('should escape special characters in table and column names', () => {
      // Given
      const schema = new DatabaseSchema('testdb');
      const table = new Table('user-profiles', [
        Column.create({ name: 'user-id', type: 'int', primaryKey: true }),
        Column.create({ name: 'full name', type: 'varchar' }),
      ]);
      schema.addTable(table);

      // When
      const result = generator.generate(schema);

      // Then
      expect(result).toContain('"user-profiles" {');
      expect(result).toContain('"user-id"');
      expect(result).toContain('"full name"');
    });

    it('should include column comments', () => {
      // Given
      const schema = new DatabaseSchema('testdb');
      const table = new Table('users', [
        Column.create({ 
          name: 'status', 
          type: 'enum', 
          comment: 'User account status'
        }),
      ]);
      schema.addTable(table);

      // When
      const result = generator.generate(schema);

      // Then
      expect(result).toContain('enum status "User account status"');
    });

    it('should combine constraints and comments', () => {
      // Given
      const schema = new DatabaseSchema('testdb');
      const table = new Table('users', [
        Column.create({ 
          name: 'nursery_id', 
          type: 'int', 
          nullable: false,
          comment: '保育所ID'
        }),
      ]);
      schema.addTable(table);

      // When
      const result = generator.generate(schema);

      // Then
      expect(result).toContain('int nursery_id "NOT NULL | 保育所ID"');
    });
  });
});