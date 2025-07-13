import { DatabaseSchema } from '../models/database-schema.js';

export interface SqlParserRepository {
  parse(sqlContent: string): Promise<DatabaseSchema>;
}