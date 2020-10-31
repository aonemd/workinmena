# require 'url_analyzer_client'

module Api::V1::Companies
  class AnalyzerController < ApplicationController
    def create
      url   = params[:url]
      tools = UrlAnalyzerConsumerService.new().call(url)

      render json: { tools: ToolDecorator.decorate_collection(tools) }
    end
  end
end
