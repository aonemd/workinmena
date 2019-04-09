require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'json'

BASE_URL = "https://wuzzuf.net/a/IT-Software-Development-Jobs-in-Egypt".freeze

def get_companies_in_page(page_limit)
  companies = []
  page      = Nokogiri::HTML(open(URI.parse("#{BASE_URL}?start=#{page_limit}")))
  rows      = page.css('.company-name')
  rows.each do |row|
    wazzuf_company_anchor = row.at_css('a')
    wazzuf_company_url    = wazzuf_company_anchor['href'] rescue next
    name                  = wazzuf_company_anchor.content

    begin
      wazzuf_company_page =
        Nokogiri::HTML(open(URI.parse(URI.escape(wazzuf_company_url))))
    rescue OpenURI::HTTPError
      puts name
      next
    rescue Exception => ex
      puts "Error2: #{ex}"
      next
    end

    website =
      wazzuf_company_page.css('.company-info').at_css('a').content rescue next

    next if website.length < 6

    companies.append({ name: name, website: website })
  end

  companies
end

companies = []
(0..3340).step(20) do |i|
  companies.append(get_companies_in_page(i))
end

companies = companies.flatten.uniq
file      = File.open('./scrapers/companies.json', 'a')
file.puts JSON.pretty_generate(companies)

puts "Scraped #{companies.count}"
