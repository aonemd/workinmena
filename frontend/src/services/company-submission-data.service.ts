import http from './http-client';

import { CompanySubmission } from '../types';

class CompanySubmissionDataService {
  async create(companySubmission: CompanySubmission): Promise<{message: string}> {
    const response = await http.post(
      '/companies/submissions',
      { company_submission: companySubmission }
    );
    const {data} = response;

    return data;
  }
}

export default new CompanySubmissionDataService();
