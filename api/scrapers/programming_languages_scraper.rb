require 'nokogiri'
require 'open-uri'
require 'json'

BASE_URL = 'https://en.wikipedia.org'.freeze
file     = File.open('./scrapers/programming_languages.json', "w")

def get_languages(row_number)
  languages = []
  page      = Nokogiri::HTML(open("#{BASE_URL}/wiki/Programming_languages_used_in_most_popular_websites"))
  columns   = page.css('tr')[row_number]

  language_anchors = columns.css('td')[3].css('a')
  language_anchors.each do |row|
    name     = row.content
    wiki_url = "#{row['href']}"

    next if name =~ /\[[0-9]+\]/

    language_page      = Nokogiri::HTML(open("#{BASE_URL}#{wiki_url}"))
    description        = language_page.css('.infobox')[0].next_element.content
      .gsub(/\(.*?\)/, '')
      .gsub(/\[.*?\]/, '')
      .gsub('  ', ' ')
      .chomp('.')
    website_th_element = language_page.at('th:contains("Website")')
    website            = if website_th_element
                           website_th_element.next_element.css('a').text
                         else
                           ""
                         end

    language = { name: name, website: website, description: description }
    languages.append(language)
  end

  languages
end

languages = []
(1..14).map do |i|
  languages.append(get_languages(i))
end

file.puts JSON.pretty_generate(languages.flatten.uniq)
