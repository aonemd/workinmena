class CompanyDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      id: id,
      name: name,
      website: website,
      stack: StackEntryDecorator.decorate_collection(stack),
    }
  end

  def decorate_all(options = {})
    {
      id: id,
      name: name,
      website: website,
      popular_tool: ToolDecorator.new(popular_tool).decorate,
      tool_search_pattern: ToolDecorator.decorate_collection(tools, method: :decorate_search_name).join(' ')
    }
  end
end
