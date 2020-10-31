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

  async endorse(companyId: number, stackEntryId: number): Promise<any> {
    const response = await http.put(
      `/companies/${companyId}/stacks/${stackEntryId}/endorse`
    );

    return response;
  }
}

export default new CompanyStackDataService();
