import http from './http-client';

import { Tool } from '../types';

class ToolDataService {
  async getAll(): Promise<{tools: Tool[]}> {
    const response = await http.get('/tools');
    const {data}   = response;

    return data;
  }
}

export default new ToolDataService();
