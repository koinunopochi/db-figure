import { SqlParserRepository } from '../../domain/repositories/sql-parser.repository.js';
import { DiagramGeneratorRepository } from '../../domain/repositories/diagram-generator.repository.js';
import { FileWriterRepository } from '../../domain/repositories/file-writer.repository.js';
import { DatabaseSchema } from '../../domain/models/database-schema.js';
import { MermaidGroupedGeneratorAdapter } from '../../infrastructure/adapters/mermaid-grouped-generator.adapter.js';

export interface ConversionOptions {
  outputPath?: string;
  includeTableList?: boolean;
  includeColumnDetails?: boolean;
  validateRelations?: boolean;
  maxTablesPerDiagram?: number;
  splitFiles?: boolean;
}

export class SqlToDiagramService {
  constructor(
    private readonly sqlParser: SqlParserRepository,
    private readonly diagramGenerator: DiagramGeneratorRepository,
    private readonly fileWriter: FileWriterRepository,
  ) {}

  async convertFile(sqlFilePath: string, options: ConversionOptions = {}): Promise<string> {
    // Read SQL file
    const sqlContent = await this.fileWriter.read(sqlFilePath);

    // Parse SQL to domain model
    const schema = await this.sqlParser.parse(sqlContent);

    // Handle split files if requested
    if (options.splitFiles && options.outputPath) {
      return await this.generateSplitOutput(schema, options);
    }

    // Generate output content
    const outputContent = await this.generateOutput(schema, options);

    // Write to file if output path specified
    if (options.outputPath) {
      await this.fileWriter.write(options.outputPath, outputContent);
    }

    return outputContent;
  }

  async convertContent(sqlContent: string, options: ConversionOptions = {}): Promise<string> {
    // Parse SQL to domain model
    const schema = await this.sqlParser.parse(sqlContent);

    // Handle split files if requested
    if (options.splitFiles && options.outputPath) {
      return await this.generateSplitOutput(schema, options);
    }

    // Generate output content
    const outputContent = await this.generateOutput(schema, options);

    // Write to file if output path specified
    if (options.outputPath) {
      await this.fileWriter.write(options.outputPath, outputContent);
    }

    return outputContent;
  }

  private async generateOutput(schema: DatabaseSchema, options: ConversionOptions): Promise<string> {
    const sections: string[] = [];

    // Add header
    sections.push(`# Database Schema: ${schema.name}`);
    sections.push('');
    sections.push(`Generated on: ${new Date().toISOString()}`);
    sections.push('');

    // Validate relations if requested
    if (options.validateRelations) {
      const errors = schema.validateRelations();
      if (errors.length > 0) {
        sections.push('## ⚠️ Validation Errors');
        sections.push('');
        errors.forEach(error => sections.push(`- ${error}`));
        sections.push('');
      }
    }

    // Check if we need to split into multiple diagrams
    if (options.maxTablesPerDiagram && schema.tables.length > options.maxTablesPerDiagram) {
      sections.push('## Entity Relationship Diagrams');
      sections.push('');
      sections.push(`> Database contains ${schema.tables.length} tables, split into multiple diagrams for clarity.`);
      sections.push('');
      
      // Use grouped generator if available
      if (this.diagramGenerator instanceof MermaidGroupedGeneratorAdapter) {
        const diagrams = this.diagramGenerator.generateGrouped(schema, { 
          maxTablesPerDiagram: options.maxTablesPerDiagram 
        });
        
        diagrams.forEach((diagram, groupName) => {
          sections.push(`### ${groupName}`);
          sections.push('');
          sections.push(diagram);
          sections.push('');
        });
      } else {
        // Fallback to single diagram
        sections.push(this.diagramGenerator.generate(schema));
        sections.push('');
      }
    } else {
      // Single diagram for small schemas
      sections.push('## Entity Relationship Diagram');
      sections.push('');
      sections.push(this.diagramGenerator.generate(schema));
      sections.push('');
    }

    // Add table list if requested
    if (options.includeTableList) {
      sections.push('## Tables');
      sections.push('');
      sections.push(`Total tables: ${schema.tables.length}`);
      sections.push('');
      
      schema.tables.forEach(table => {
        sections.push(`- **${table.name}**${table.comment ? `: ${table.comment}` : ''}`);
      });
      sections.push('');
    }

    // Add detailed column information if requested
    if (options.includeColumnDetails) {
      sections.push('## Table Details');
      sections.push('');

      schema.tables.forEach(table => {
        sections.push(`### ${table.name}`);
        if (table.comment) {
          sections.push(`> ${table.comment}`);
        }
        sections.push('');

        // Columns table
        sections.push('| Column | Type | Nullable | Key | Default | Comment |');
        sections.push('|--------|------|----------|-----|---------|---------|');
        
        table.columns.forEach(column => {
          const nullable = column.nullable ? 'YES' : 'NO';
          const key = column.primaryKey ? 'PK' : '';
          const defaultVal = column.defaultValue || '';
          const comment = column.comment || '';
          
          sections.push(`| ${column.name} | ${column.type}${column.length ? `(${column.length})` : ''} | ${nullable} | ${key} | ${defaultVal} | ${comment} |`);
        });
        sections.push('');

        // Foreign keys
        if (table.foreignKeys.length > 0) {
          sections.push('**Foreign Keys:**');
          sections.push('');
          table.foreignKeys.forEach(fk => {
            sections.push(`- \`${fk.name}\`: ${fk.columnName} → ${fk.referencedTableName}.${fk.referencedColumnName}`);
            if (fk.onDelete || fk.onUpdate) {
              const actions: string[] = [];
              if (fk.onDelete) actions.push(`ON DELETE ${fk.onDelete}`);
              if (fk.onUpdate) actions.push(`ON UPDATE ${fk.onUpdate}`);
              sections.push(`  - ${actions.join(', ')}`);
            }
          });
          sections.push('');
        }

        // Indexes
        if (table.indexes.length > 0) {
          sections.push('**Indexes:**');
          sections.push('');
          table.indexes.forEach(idx => {
            sections.push(`- \`${idx.name}\` (${idx.type}): ${idx.columns.join(', ')}`);
          });
          sections.push('');
        }
      });
    }

    return sections.join('\n');
  }

  private async generateSplitOutput(schema: DatabaseSchema, options: ConversionOptions): Promise<string> {
    if (!options.outputPath) {
      throw new Error('Output path is required for split files');
    }

    // Extract base path and extension
    const lastDotIndex = options.outputPath.lastIndexOf('.');
    const basePath = lastDotIndex !== -1 ? options.outputPath.substring(0, lastDotIndex) : options.outputPath;
    const extension = lastDotIndex !== -1 ? options.outputPath.substring(lastDotIndex) : '.md';

    // Generate diagram file
    const diagramPath = `${basePath}-diagram${extension}`;
    const diagramContent = await this.generateDiagramOnlyOutput(schema, options);
    await this.fileWriter.write(diagramPath, diagramContent);

    // Generate details file if requested
    let detailsPath: string | undefined;
    if (options.includeTableList || options.includeColumnDetails) {
      detailsPath = `${basePath}-details${extension}`;
      const detailsContent = await this.generateDetailsOnlyOutput(schema, options);
      await this.fileWriter.write(detailsPath, detailsContent);
    }

    // Generate summary file with links
    const summaryContent = this.generateSummaryOutput(schema, diagramPath, detailsPath);
    await this.fileWriter.write(options.outputPath, summaryContent);

    return summaryContent;
  }

  private async generateDiagramOnlyOutput(schema: DatabaseSchema, options: ConversionOptions): Promise<string> {
    const sections: string[] = [];

    // Add header
    sections.push(`# Database Schema Diagrams: ${schema.name}`);
    sections.push('');
    sections.push(`Generated on: ${new Date().toISOString()}`);
    sections.push('');

    // Add ER diagrams only
    const diagramOptions = { ...options, includeTableList: false, includeColumnDetails: false };
    const tempOutput = await this.generateOutput(schema, diagramOptions);
    
    // Extract just the diagram section
    const diagramStart = tempOutput.indexOf('## Entity Relationship Diagram');
    if (diagramStart !== -1) {
      const nextSection = tempOutput.indexOf('\n## ', diagramStart + 1);
      const diagramSection = nextSection !== -1 
        ? tempOutput.substring(diagramStart, nextSection)
        : tempOutput.substring(diagramStart);
      sections.push(diagramSection);
    }

    return sections.join('\n');
  }

  private async generateDetailsOnlyOutput(schema: DatabaseSchema, options: ConversionOptions): Promise<string> {
    const sections: string[] = [];

    // Add header
    sections.push(`# Database Schema Details: ${schema.name}`);
    sections.push('');
    sections.push(`Generated on: ${new Date().toISOString()}`);
    sections.push('');

    // Validate relations if requested
    if (options.validateRelations) {
      const errors = schema.validateRelations();
      if (errors.length > 0) {
        sections.push('## ⚠️ Validation Errors');
        sections.push('');
        errors.forEach(error => sections.push(`- ${error}`));
        sections.push('');
      }
    }

    // Add table list if requested
    if (options.includeTableList) {
      sections.push('## Tables');
      sections.push('');
      sections.push(`Total tables: ${schema.tables.length}`);
      sections.push('');
      
      schema.tables.forEach(table => {
        sections.push(`- **${table.name}**${table.comment ? `: ${table.comment}` : ''}`);
      });
      sections.push('');
    }

    // Add detailed column information if requested
    if (options.includeColumnDetails) {
      sections.push('## Table Details');
      sections.push('');

      schema.tables.forEach(table => {
        sections.push(`### ${table.name}`);
        if (table.comment) {
          sections.push(`> ${table.comment}`);
        }
        sections.push('');

        // Columns table
        sections.push('| Column | Type | Nullable | Key | Default | Comment |');
        sections.push('|--------|------|----------|-----|---------|---------|');
        
        table.columns.forEach(column => {
          const nullable = column.nullable ? 'YES' : 'NO';
          const key = column.primaryKey ? 'PK' : '';
          const defaultVal = column.defaultValue || '';
          const comment = column.comment || '';
          
          sections.push(`| ${column.name} | ${column.type}${column.length ? `(${column.length})` : ''} | ${nullable} | ${key} | ${defaultVal} | ${comment} |`);
        });
        sections.push('');

        // Foreign keys
        if (table.foreignKeys.length > 0) {
          sections.push('**Foreign Keys:**');
          sections.push('');
          table.foreignKeys.forEach(fk => {
            sections.push(`- \`${fk.name}\`: ${fk.columnName} → ${fk.referencedTableName}.${fk.referencedColumnName}`);
            if (fk.onDelete || fk.onUpdate) {
              const actions: string[] = [];
              if (fk.onDelete) actions.push(`ON DELETE ${fk.onDelete}`);
              if (fk.onUpdate) actions.push(`ON UPDATE ${fk.onUpdate}`);
              sections.push(`  - ${actions.join(', ')}`);
            }
          });
          sections.push('');
        }

        // Indexes
        if (table.indexes.length > 0) {
          sections.push('**Indexes:**');
          sections.push('');
          table.indexes.forEach(idx => {
            sections.push(`- \`${idx.name}\` (${idx.type}): ${idx.columns.join(', ')}`);
          });
          sections.push('');
        }
      });
    }

    return sections.join('\n');
  }

  private generateSummaryOutput(schema: DatabaseSchema, diagramPath: string, detailsPath?: string): string {
    const sections: string[] = [];

    sections.push(`# Database Schema: ${schema.name}`);
    sections.push('');
    sections.push(`Generated on: ${new Date().toISOString()}`);
    sections.push('');
    sections.push('## Generated Files');
    sections.push('');
    sections.push(`- **ER Diagrams**: [${diagramPath}](${diagramPath})`);
    
    if (detailsPath) {
      sections.push(`- **Table Details**: [${detailsPath}](${detailsPath})`);
    }
    
    sections.push('');
    sections.push('## Summary');
    sections.push('');
    sections.push(`- Total tables: ${schema.tables.length}`);
    sections.push(`- Total relationships: ${schema.tables.reduce((sum, table) => sum + table.foreignKeys.length, 0)}`);
    sections.push('');

    return sections.join('\n');
  }
}