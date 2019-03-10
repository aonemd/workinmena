require 'nokogiri'
require 'open-uri'

BASE_URL  = 'https://en.wikipedia.org'.freeze
file      = File.open('programming_languages.json', "a")

def get_languages(row_number)
  languages = []
  page      = Nokogiri::HTML(open("#{BASE_URL}/wiki/Programming_languages_used_in_most_popular_websites"))
  columns   = page.css('tr')[row_number]

  language_anchors = columns.css('td')[3].css('a')
  language_anchors.each do |row|
    name     = row.content
    wiki_url = "#{row['href']}"

    next if name =~ /\[[0-9]+\]/

    language = { name: name, website: '', description: '' }
    languages.append(language)
  end

  languages
end

languages = []
(1..14).map do |i|
  languages.append(get_languages(i))
end
