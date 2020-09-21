class CompanyDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      id: id,
      name: name,
      website: website,
      tools: ToolDecorator.decorate_collection(tools)
    }
  end

  def decorate_all(options = {})
    {
      id: id,
      name: name,
      website: website,
      popular_tool: ToolDecorator.new(popular_tool).decorate
    }
  end
end
