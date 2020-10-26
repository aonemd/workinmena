class ToolDecorator < Geckorate::Decorator
  def decorate(options = {})
    return decorate_null(options) if __getobj__.nil?

    {
      id: id,
      name: name,
      website: website,
      category: Tool::CategoryDecorator.new(category).name
    }
  end

  def decorate_full(options = {})
    return decorate_null(options) if __getobj__.nil?

    {
      id: id,
      name: name,
      description: description,
      website: website,
      category: Tool::CategoryDecorator.new(category).name
    }
  end

  def decorate_null(options = {})
    {
      id: '-',
      name: '-',
      description: '-',
      website: '-',
      category: '-'
    }
  end

  def decorate_search_name(options = {})
    __getobj__.name.gsub(/\.|-/, ' ').downcase
  end
end
