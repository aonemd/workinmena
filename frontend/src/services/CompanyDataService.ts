import axios from "axios";

const http = axios.create({
  baseURL: 'http://localhost:3000/api/v1',
  responseType: 'json',
  headers: { 'Content-Type': 'application/json' }
});

class CompanyDataService {
  async getAll() {
    const response = await http.get('/companies');
    const {data}   = response;

    return data;
  }
}

export default new CompanyDataService();
