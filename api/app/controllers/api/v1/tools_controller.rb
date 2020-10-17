class Api::V1::ToolsController < ApplicationController
  def index
    tools = Tool.all

    render json: { tools: ToolDecorator.decorate_collection(tools, method: :decorate_list) }
  end
end
