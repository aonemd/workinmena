require 'nokogiri'
require 'open-uri'
require 'json'

BASE_URL = "https://22startup.com".freeze
file     = File.open('./scrapers/companies.json', 'a')

def get_companies_in_page(page_number)
  companies = []
  page      = Nokogiri::HTML(open("#{BASE_URL}/?page=#{page_number}"))
  rows      = page.css('.post-title')
  rows.each do |row|
    company_anchor = "#{BASE_URL}#{row['href']}"
    company_page   = Nokogiri::HTML(open(company_anchor))

    name    = row.content.strip
    website = company_page.css('.pga_link-url')[0].content

    companies.append({ name: name, website: website })
  end

  companies
end

companies = []
(1..4).map do |i|
  companies.append(get_companies_in_page(i))
end

file.puts JSON.pretty_generate(companies.flatten.uniq)
