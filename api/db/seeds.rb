puts "Seeding tool categories..."
tool_categories = ActiveSupport::JSON.decode(File.read('db/seeds/tool_categories.json'))
tool_categories.each do |tool_category|
  Tool::Category.create(name: tool_category['name'])
end

puts "Seeding tools..."
programming_language_tools = ActiveSupport::JSON.decode(File.read('db/seeds/programming_languages.json'))
language_category          = Tool::Category.first
programming_language_tools.each do |programming_language|
  Tool.create(name: programming_language['name'],
              website: programming_language['website'],
              description: programming_language['description'],
              category: language_category)
end

database_tools    = ActiveSupport::JSON.decode(File.read('db/seeds/databases.json'))
database_category = Tool::Category.where(name: 'Database').first
database_tools.each do |database|
  Tool.create(name: database['name'],
              website: database['website'],
              description: database['description'],
              category: database_category)
end

framework_tools    = ActiveSupport::JSON.decode(File.read('db/seeds/frameworks.json'))
framework_category = Tool::Category.where(name: 'Framework').first
framework_tools.each do |framework|
  Tool.create(name: framework['name'],
              website: framework['website'],
              description: framework['description'],
              category: framework_category)
end

infrastructure_tools    = ActiveSupport::JSON.decode(File.read('db/seeds/infrastructure.json'))
infrastructure_category = Tool::Category.where(name: 'Infrastructure').first
infrastructure_tools.each do |infrastructure|
  Tool.create(name: infrastructure['name'],
              website: infrastructure['website'],
              description: infrastructure['description'],
              category: infrastructure_category)
end

puts "Seeding companies..."
companies = ActiveSupport::JSON.decode(File.read('db/seeds/companies.json'))
companies.each do |company|
  co = Company.create(name: company['name'], website: company['website'])
  next unless co.save

  company['tools'].each do |tool_name|
    tool = Tool.find_by_name(tool_name)
    co.stack.create(tool: tool) if tool
  end
end
