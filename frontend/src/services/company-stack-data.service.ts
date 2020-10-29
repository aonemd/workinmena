import http from './http-client';

import { Stack } from '../types';

class CompanyStackDataService {
  async create(companyId: number, stack: Stack[]): Promise<any> {
    const response = await http.post(
      `/companies/${companyId}/stacks`,
      { stack: stack }
    );

    return response;
  }
}

export default new CompanyStackDataService();
