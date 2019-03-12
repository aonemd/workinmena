require 'nokogiri'
require 'open-uri'
require 'json'

BASE_URL = 'https://hotframeworks.com'.freeze
file     = File.open('./scrapers/frameworks.json', "w")

def get_framework(row_number)
  begin
    page        = Nokogiri::HTML(open("#{BASE_URL}"))
  rescue Exception => ex
    puts "Error1: #{ex}"
    retry
  end
  name_column = page.css('tr')[row_number]

  framework_anchor = name_column.css('td')[0].css('a')[0]
  name             = framework_anchor.content
  url              = framework_anchor['href']

  begin
    framework_page = Nokogiri::HTML(open("#{BASE_URL}#{url}"))
  rescue OpenURI::HTTPError
    puts name
    return
  rescue Exception => ex
    puts "Error2: #{ex}"
    retry
  end
  description = if framework_page.css('p')[0].content.include?('Description')
                  framework_page.css('p')[0].content.gsub('Description: ', '')
                else
                  ''
                end.chomp('.')
  website     = framework_page.css('p')[2].css('a')[0]['href']

  { name: name, website: website, description: description }
end

frameworks = []
(1..186).map do |i|
  frameworks.append(get_framework(i))
end

file.puts JSON.pretty_generate(frameworks.uniq)
