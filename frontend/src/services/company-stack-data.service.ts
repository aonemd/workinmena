import http from './http-client';

import { StackEntrySubmission, StackEntry, } from '../types';

class CompanyStackDataService {
  async create(companyId: number, stackEntries: StackEntrySubmission[]): Promise<{stack_entries: StackEntry[]}> {
    const response = await http.post(
      `/companies/${companyId}/stacks`,
      { stack: stackEntries }
    );
    const {data}   = response;

    return data;
  }
}

export default new CompanyStackDataService();
