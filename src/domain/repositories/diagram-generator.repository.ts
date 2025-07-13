import { DatabaseSchema } from '../models/database-schema.js';

export interface DiagramGeneratorRepository {
  generate(schema: DatabaseSchema): string;
}