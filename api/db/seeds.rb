tool_categories = ActiveSupport::JSON.decode(File.read('db/seeds/tool_categories.json'))
tool_categories.each do |tool_category|
  Tool::Category.create(name: tool_category['name'])
end

programming_language_tools = ActiveSupport::JSON.decode(File.read('db/seeds/programming_languages.json'))
language_category          = Tool::Category.first
programming_language_tools.each do |programming_language|
  Tool.create(name: programming_language['name'],
              website: programming_language['website'],
              description: programming_language['description'],
              category: language_category)
end
