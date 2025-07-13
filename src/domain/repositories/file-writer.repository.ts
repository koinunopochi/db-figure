export interface FileWriterRepository {
  write(path: string, content: string): Promise<void>;
  read(path: string): Promise<string>;
}