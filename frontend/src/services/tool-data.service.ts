import axios from "axios";

import { Tool } from '../types';

const http = axios.create({
  baseURL: 'http://localhost:3000/api/v1',
  responseType: 'json',
  headers: { 'Content-Type': 'application/json' }
});

class ToolDataService {
  async getAll(): Promise<{tools: Tool[]}> {
    const response = await http.get('/tools');
    const {data}   = response;

    return data;
  }
}

export default new ToolDataService();
