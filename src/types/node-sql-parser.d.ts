declare module 'node-sql-parser' {
  export class Parser {
    constructor();
    parse(sql: string, options?: any): any;
    astify(sql: string, options?: any): any;
    sqlify(ast: any, options?: any): string;
    whiteListCheck(sql: string, whiteList: string[], options?: any): void;
  }
}