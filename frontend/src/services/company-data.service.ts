import http from './http-client';

import { Company } from '../types';

class CompanyDataService {
  async getAll(): Promise<{companies: Company[]}> {
    const response = await http.get('/companies');
    const {data}   = response;

    return data;
  }

  async getLimited(limit: number): Promise<{companies: Company[]}> {
    const response = await http.get(`/companies?limit=${limit}`);
    const {data}   = response;

    return data;
  }

  async getOne(id: number): Promise<{company: Company}> {
    const response = await http.get(`/companies/${id}`);
    const {data}   = response;

    return data;
  }
}

export default new CompanyDataService();
