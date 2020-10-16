import Tool from './Tool';

export default interface Company {
  id: number,
  name: string,
  website: string,
  tools: Tool[],
  tool_search_pattern: string,
}
