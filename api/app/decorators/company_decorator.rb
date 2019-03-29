class CompanyDecorator < Geckorate::Decorator
  def decorate
    {
      name: name,
      tools: ToolDecorator.decorate_collection(tools)
    }.as_json
  end
end
