import axios from "axios";

import { CompanySubmission } from '../types';

const http = axios.create({
  baseURL: 'http://localhost:3000/api/v1',
  responseType: 'json',
  headers: { 'Content-Type': 'application/json' }
});

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
