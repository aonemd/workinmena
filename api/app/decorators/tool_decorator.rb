class ToolDecorator < Geckorate::Decorator
  def decorate(options = {})
    {
      name: name,
      description: description,
      category: Tool::CategoryDecorator.new(category).name
    }
  end
end
