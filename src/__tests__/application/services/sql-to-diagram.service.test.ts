import { describe, it, expect, vi } from 'vitest';
import { SqlToDiagramService } from '../../../application/services/sql-to-diagram.service.js';
import { DatabaseSchema } from '../../../domain/models/database-schema.js';
import { Table } from '../../../domain/models/table.js';
import { Column } from '../../../domain/value-objects/column.js';

describe('SqlToDiagramService', () => {
  const mockSqlParser = {
    parse: vi.fn(),
  };

  const mockDiagramGenerator = {
    generate: vi.fn(),
  };

  const mockFileWriter = {
    write: vi.fn(),
    read: vi.fn(),
  };

  const service = new SqlToDiagramService(
    mockSqlParser,
    mockDiagramGenerator,
    mockFileWriter,
  );

  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('convertContent', () => {
    it('should convert SQL content to markdown with diagram', async () => {
      // Given
      const sqlContent = 'CREATE TABLE test (id INT);';
      const schema = new DatabaseSchema('testdb');
      schema.addTable(new Table('test', [
        Column.create({ name: 'id', type: 'int' }),
      ]));

      mockSqlParser.parse.mockResolvedValue(schema);
      mockDiagramGenerator.generate.mockReturnValue('```mermaid\nerDiagram\n```');

      // When
      const result = await service.convertContent(sqlContent);

      // Then
      expect(mockSqlParser.parse).toHaveBeenCalledWith(sqlContent);
      expect(mockDiagramGenerator.generate).toHaveBeenCalledWith(schema);
      expect(result).toContain('# Database Schema: testdb');
      expect(result).toContain('## Entity Relationship Diagram');
      expect(result).toContain('```mermaid');
    });

    it('should include table list when option is enabled', async () => {
      // Given
      const sqlContent = 'CREATE TABLE users (id INT);';
      const schema = new DatabaseSchema('testdb');
      schema.addTable(new Table('users', [], [], [], 'User accounts'));

      mockSqlParser.parse.mockResolvedValue(schema);
      mockDiagramGenerator.generate.mockReturnValue('');

      // When
      const result = await service.convertContent(sqlContent, { includeTableList: true });

      // Then
      expect(result).toContain('## Tables');
      expect(result).toContain('Total tables: 1');
      expect(result).toContain('- **users**: User accounts');
    });

    it('should include column details when option is enabled', async () => {
      // Given
      const sqlContent = 'CREATE TABLE users (id INT);';
      const schema = new DatabaseSchema('testdb');
      const table = new Table('users', [
        Column.create({ 
          name: 'id', 
          type: 'int', 
          primaryKey: true, 
          nullable: false,
          comment: 'User identifier',
        }),
      ]);
      schema.addTable(table);

      mockSqlParser.parse.mockResolvedValue(schema);
      mockDiagramGenerator.generate.mockReturnValue('');

      // When
      const result = await service.convertContent(sqlContent, { includeColumnDetails: true });

      // Then
      expect(result).toContain('## Table Details');
      expect(result).toContain('### users');
      expect(result).toContain('| Column | Type | Nullable | Key | Default | Comment |');
      expect(result).toContain('| id | int | NO | PK |  | User identifier |');
    });

    it('should write to file when output path is provided', async () => {
      // Given
      const sqlContent = 'CREATE TABLE test (id INT);';
      const outputPath = '/output/schema.md';
      const schema = new DatabaseSchema('testdb');

      mockSqlParser.parse.mockResolvedValue(schema);
      mockDiagramGenerator.generate.mockReturnValue('');

      // When
      await service.convertContent(sqlContent, { outputPath });

      // Then
      expect(mockFileWriter.write).toHaveBeenCalledWith(outputPath, expect.any(String));
    });

    it('should include validation errors when option is enabled', async () => {
      // Given
      const sqlContent = 'CREATE TABLE test (id INT);';
      const schema = new DatabaseSchema('testdb');
      vi.spyOn(schema, 'validateRelations').mockReturnValue([
        'Table posts: Foreign key fk_user references non-existent table users',
      ]);

      mockSqlParser.parse.mockResolvedValue(schema);
      mockDiagramGenerator.generate.mockReturnValue('');

      // When
      const result = await service.convertContent(sqlContent, { validateRelations: true });

      // Then
      expect(result).toContain('## ⚠️ Validation Errors');
      expect(result).toContain('- Table posts: Foreign key fk_user references non-existent table users');
    });
  });

  describe('convertFile', () => {
    it('should read file and convert content', async () => {
      // Given
      const sqlFilePath = '/input/schema.sql';
      const sqlContent = 'CREATE TABLE test (id INT);';
      const schema = new DatabaseSchema('testdb');

      mockFileWriter.read.mockResolvedValue(sqlContent);
      mockSqlParser.parse.mockResolvedValue(schema);
      mockDiagramGenerator.generate.mockReturnValue('');

      // When
      const result = await service.convertFile(sqlFilePath);

      // Then
      expect(mockFileWriter.read).toHaveBeenCalledWith(sqlFilePath);
      expect(mockSqlParser.parse).toHaveBeenCalledWith(sqlContent);
      expect(result).toContain('# Database Schema: testdb');
    });
  });
});