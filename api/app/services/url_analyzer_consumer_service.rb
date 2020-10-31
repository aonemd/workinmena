class UrlAnalyzerConsumerService
  def initialize()
    @analyzer = UrlAnalyzerClient.new(Rails.application.credentials.url_analyzer_service_url)
  end

  def call(url)
    resp = @analyzer.call(url)
    Tool.where(name: resp.fetch("tools"))
  end
end
