tool_categories = ActiveSupport::JSON.decode(File.read('db/seeds/tool_categories.json'))
tool_categories.each do |tool_category|
  Tool::Category.create(name: tool_category['name'])
end
