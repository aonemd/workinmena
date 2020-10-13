import axios from "axios";

import { Company } from '../interfaces';

const http = axios.create({
  baseURL: 'http://localhost:3000/api/v1',
  responseType: 'json',
  headers: { 'Content-Type': 'application/json' }
});

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
