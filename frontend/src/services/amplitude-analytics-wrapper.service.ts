const amplitude = require('amplitude-js');

amplitude
  .getInstance()
  .init(
    "7c92416d3c8102b79c6b0a54ebad48bf",
    null,
    {includeReferrer: true, includeUtm: true, includeGclid: true}
  );

export default amplitude.getInstance();
