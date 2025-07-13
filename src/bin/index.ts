#!/usr/bin/env node
import { Command } from 'commander';
import chalk from 'chalk';
import ora from 'ora';
import { resolve } from 'path';
import { existsSync } from 'fs';
import { SqlToDiagramService } from '../application/services/sql-to-diagram.service.js';
import { SimpleSqlParserAdapter } from '../infrastructure/adapters/simple-sql-parser.adapter.js';
import { MermaidGeneratorAdapter } from '../infrastructure/adapters/mermaid-generator.adapter.js';
import { MermaidGroupedGeneratorAdapter } from '../infrastructure/adapters/mermaid-grouped-generator.adapter.js';
import { FileSystemAdapter } from '../infrastructure/adapters/file-system.adapter.js';

const program = new Command();

program
  .name('sql-to-mermaid')
  .description('Convert SQL files to Mermaid ER diagrams')
  .version('1.0.0')
  .argument('<sql-file>', 'Path to SQL file')
  .option('-o, --output <path>', 'Output file path (default: <input-file>.md)')
  .option('-t, --table-list', 'Include table list in output', false)
  .option('-d, --details', 'Include detailed column information', false)
  .option('-v, --validate', 'Validate foreign key relations', false)
  .option('-m, --max-tables <number>', 'Maximum tables per diagram (splits large schemas)', parseInt)
  .option('-s, --split', 'Split diagrams and details into separate files', false)
  .action(async (sqlFile: string, options) => {
    const spinner = ora('Processing SQL file...').start();

    try {
      // Resolve file paths
      const inputPath = resolve(sqlFile);
      
      // Check if input file exists
      if (!existsSync(inputPath)) {
        spinner.fail(chalk.red(`Input file not found: ${inputPath}`));
        process.exit(1);
      }

      // Determine output path
      const outputPath = options.output 
        ? resolve(options.output)
        : inputPath.replace(/\.sql$/i, '.md');

      // Initialize dependencies
      const sqlParser = new SimpleSqlParserAdapter();
      const diagramGenerator = options.maxTables 
        ? new MermaidGroupedGeneratorAdapter()
        : new MermaidGeneratorAdapter();
      const fileWriter = new FileSystemAdapter();
      
      // Create service
      const service = new SqlToDiagramService(
        sqlParser,
        diagramGenerator,
        fileWriter,
      );

      // Convert file
      spinner.text = 'Parsing SQL and generating diagram...';
      
      await service.convertFile(inputPath, {
        outputPath,
        includeTableList: options.tableList,
        includeColumnDetails: options.details,
        validateRelations: options.validate,
        maxTablesPerDiagram: options.maxTables,
        splitFiles: options.split,
      });

      spinner.succeed(chalk.green(`✓ Successfully generated: ${outputPath}`));

      // Print summary
      console.log('');
      console.log(chalk.blue('Summary:'));
      console.log(`  Input:  ${inputPath}`);
      console.log(`  Output: ${outputPath}`);
      
      if (options.tableList || options.details || options.validate || options.maxTables || options.split) {
        console.log('  Options:');
        if (options.tableList) console.log('    - Table list included');
        if (options.details) console.log('    - Column details included');
        if (options.validate) console.log('    - Relations validated');
        if (options.maxTables) console.log(`    - Max tables per diagram: ${options.maxTables}`);
        if (options.split) console.log('    - Split into separate files');
      }

    } catch (error) {
      spinner.fail(chalk.red('Failed to process SQL file'));
      console.error('');
      console.error(chalk.red('Error:'), error instanceof Error ? error.message : error);
      process.exit(1);
    }
  });

// Error handling
program.exitOverride();

try {
  program.parse(process.argv);
} catch (error: any) {
  if (error.code === 'commander.missingArgument') {
    console.error(chalk.red('Error: Missing required argument'));
    console.error('');
    program.outputHelp();
  } else {
    console.error(chalk.red('Error:'), error.message);
  }
  process.exit(1);
}