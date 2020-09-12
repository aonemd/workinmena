require 'json'
require 'net/http'

ANALYZER_API_URL = 'http://localhost:3001'.freeze

def fetch_tools(url)
  uri      = URI(ANALYZER_API_URL)
  http     = Net::HTTP.new(uri.host, uri.port)
  req      = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
  req.body = ({ url: url }).to_json
  res      = http.request(req)

  JSON.parse(res.body)
end

read_file = File.open('./scrapers/companies.json', 'a+')
data      = JSON.parse(read_file.read)
read_file.close

companies = []
data.each do |row|
  tools   = fetch_tools(row['website']).fetch('tools', []).uniq rescue next
  company = { name: row['name'], website: row['website'], tools: tools }
  companies.append(company)
end

write_file = File.open('./scrapers/companies-tools.json', 'a+')
write_file.puts(JSON.pretty_generate(companies))
write_file.close

puts "Processed #{companies.count}"
