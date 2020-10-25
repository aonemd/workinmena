import Tool from './Tool.types';

export default interface CompanySubmission {
  name: string,
  website: string,
  tools: Tool[],
}
