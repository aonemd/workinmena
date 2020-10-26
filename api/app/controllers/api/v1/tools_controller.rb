class Api::V1::ToolsController < ApplicationController
  def index
    decorated_tools = ToolDecorator.decorate_collection(Tool.all)

    render json: { tools: decorated_tools }
  end
end
