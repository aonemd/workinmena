class UrlAnalyzerConsumerService
  def initialize()
    @analyzer = UrlAnalyzerClient.new(Rails.application.credentials.url_analyzer_service_url)
  end

  def call(url)
    resp  = @analyzer.call(url)
    tools = resp.fetch("tools").map do |tool|
      conversions_table.fetch(tool, tool)
    end

    Tool.where(name: tools)
  end

  private

  def conversions_table
    {
      'Amazon Web Services' => 'AWS',
    }
  end
end
