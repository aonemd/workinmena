import StackEntry from './stack-entry.type';
import Tool from './tool.type';

export default interface Company {
  id: number;
  name: string;
  website: string;
  stack: StackEntry[];
  popular_tool: Tool,
  tool_search_pattern: string;
}
