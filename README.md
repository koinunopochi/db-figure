# SQL to Mermaid

Convert SQL files to Mermaid ER diagrams with detailed documentation.

## Installation

```bash
npx sql-to-mermaid <sql-file>
```

Or install globally:

```bash
npm install -g sql-to-mermaid
```

## Usage

### Basic usage

```bash
sql-to-mermaid schema.sql
```

This will create `schema.md` with a Mermaid ER diagram.

### Options

```bash
sql-to-mermaid schema.sql -o output.md   # Specify output file
sql-to-mermaid schema.sql -t             # Include table list
sql-to-mermaid schema.sql -d             # Include column details
sql-to-mermaid schema.sql -v             # Validate foreign key relations
sql-to-mermaid schema.sql -tdv           # All options combined
```

## Features

- **Automatic ER Diagram Generation**: Creates Mermaid ER diagrams from SQL CREATE TABLE statements
- **Foreign Key Visualization**: Shows relationships between tables with proper cardinality
- **Comprehensive Documentation**: Optionally includes:
  - Table lists with descriptions
  - Detailed column information (type, nullable, keys, defaults, comments)
  - Foreign key constraints with ON DELETE/UPDATE actions
  - Index information
- **Validation**: Checks for invalid foreign key references
- **Support for Multiple SQL Dialects**: Handles MySQL, PostgreSQL, and other SQL variants

## Example Output

```markdown
# Database Schema: mydb

Generated on: 2024-01-01T00:00:00.000Z

## Entity Relationship Diagram

​```mermaid
erDiagram
    users {
        int id "PK, AI, NOT NULL"
        string name "NOT NULL"
        string email
        timestamp created_at
    }

    posts {
        int id "PK, AI, NOT NULL"
        int user_id "NOT NULL"
        string title "NOT NULL"
        string content
    }

    users ||--|{ posts : "fk_posts_user"
​```
```

## Architecture

This tool follows Domain-Driven Design (DDD) principles with clean architecture:

- **Domain Layer**: Core business logic (Table, Column, ForeignKey, Index entities)
- **Application Layer**: Use cases and services (SqlToDiagramService)
- **Infrastructure Layer**: External adapters (SQL parser, Mermaid generator, file system)
- **Presentation Layer**: CLI interface

## Development

```bash
# Install dependencies
npm install

# Run tests
npm test

# Run with coverage
npm run test:coverage

# Build
npm run build

# Development mode
npm run dev -- test.sql
```

## License

MIT