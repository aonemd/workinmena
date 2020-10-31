require 'net/http'

class UrlAnalyzerClient
  def initialize(analyzer_url)
    uri   = URI(analyzer_url)
    @http = Net::HTTP.new(uri.host, uri.port)
    @req  = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  end

  def call(url)
    @req.body = ({ url: url }).to_json
    res       = @http.request(@req)

    JSON.parse(res.body)
  end
end
