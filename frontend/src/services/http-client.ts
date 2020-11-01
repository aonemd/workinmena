import axios from "axios";

import { API_URL } from '../constants';

export default axios.create({
  baseURL: `${API_URL}/api/v1`,
  responseType: 'json',
  headers: { 'Content-Type': 'application/json' }
});
