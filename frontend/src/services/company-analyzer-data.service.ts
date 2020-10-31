import http from './http-client';

import { Tool } from '../types';

class CompanyAnalyzerDataService {
  async create(url: string): Promise<{tools: Tool[]}> {
    const response = await http.post(
      '/companies/analyzer',
      { url: url }
    );
    const {data} = response;

    return data;
  }
}

export default new CompanyAnalyzerDataService();
