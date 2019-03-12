require 'nokogiri'
require 'open-uri'
require 'json'

BASE_URL = 'https://en.wikipedia.org'.freeze
file     = File.open('./scrapers/databases.json', "w")

def get_databases(row_number)
  databases = []
  page      = Nokogiri::HTML(open("#{BASE_URL}/wiki/Programming_languages_used_in_most_popular_websites"))
  columns   = page.css('tr')[row_number]

  database_anchors = columns.css('td')[4].css('a')
  database_anchors.each do |row|
    name     = row.content
    wiki_url = "#{row['href']}"

    next if name =~ /\[[0-9]+\]/

    database_page      = Nokogiri::HTML(open("#{BASE_URL}#{wiki_url}"))
    description        = database_page.css('.infobox')[0].next_element.content
      .gsub(/\(.*?\)/, '')
      .gsub(/\[.*?\]/, '')
      .gsub('  ', ' ')
      .chomp
      .chomp('.')
      .strip
    website_th_element = database_page.at('th:contains("Website")')
    website            = if website_th_element
                           website_th_element.next_element.css('a').text
                         else
                           ""
                         end

    database = { name: name, website: website, description: description }
    databases.append(database)
  end

  databases
end

databases = []
(1..14).map do |i|
  databases.append(get_databases(i))
end

file.puts JSON.pretty_generate(databases.flatten.uniq)
