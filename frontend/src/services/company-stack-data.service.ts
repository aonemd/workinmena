import http from './http-client';

import { StackEntry } from '../types';

class CompanyStackDataService {
  async create(companyId: number, stackEntries: StackEntry[]): Promise<any> {
    const response = await http.post(
      `/companies/${companyId}/stacks`,
      { stack: stackEntries }
    );

    return response;
  }
}

export default new CompanyStackDataService();
