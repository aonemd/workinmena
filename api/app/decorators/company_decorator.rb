class CompanyDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      name: name,
      website: website,
      tools: ToolDecorator.decorate_collection(tools)
    }
  end
end
