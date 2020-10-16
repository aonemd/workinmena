class ToolDecorator < Geckorate::Decorator
  def decorate(options = {})
    return decorate_null(options) if __getobj__.nil?

    {
      name: name,
      description: description,
      website: website,
      category: Tool::CategoryDecorator.new(category).name
    }
  end

  def decorate_null(options = {})
    {
      name: '-',
      description: '-',
      website: '-',
      category: '-'
    }
  end
end
