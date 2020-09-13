class CompanyDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      id: id,
      name: name,
      website: website,
      tools: ToolDecorator.decorate_collection(tools)
    }
  end
end
