import { promises as fs } from 'fs';
import { dirname } from 'path';
import { FileWriterRepository } from '../../domain/repositories/file-writer.repository.js';

export class FileSystemAdapter implements FileWriterRepository {
  async write(path: string, content: string): Promise<void> {
    try {
      // Ensure directory exists
      const dir = dirname(path);
      await fs.mkdir(dir, { recursive: true });

      // Write file
      await fs.writeFile(path, content, 'utf-8');
    } catch (error) {
      throw new Error(`Failed to write file ${path}: ${error}`);
    }
  }

  async read(path: string): Promise<string> {
    try {
      return await fs.readFile(path, 'utf-8');
    } catch (error) {
      throw new Error(`Failed to read file ${path}: ${error}`);
    }
  }
}