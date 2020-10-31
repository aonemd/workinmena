import Tool from './tool.type';

export default interface StackEntry {
  id: number;
  community: boolean;
  endorsements: number;
  tool: Tool;
}
