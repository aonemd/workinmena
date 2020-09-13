class CompanyDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      name: name,
      tools: ToolDecorator.decorate_collection(tools)
    }
  end
end
