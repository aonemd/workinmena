const amplitude = require('amplitude-js');

import { AMPLITUDE_API_KEY } from '../constants';

amplitude
  .getInstance()
  .init(
    AMPLITUDE_API_KEY,
    null,
    {includeReferrer: true, includeUtm: true, includeGclid: true}
  );

export default amplitude.getInstance();
