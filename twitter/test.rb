require 'twitter'
require 'dotenv'
require 'google_drive'

Dotenv.load('../file.env')

client = Twitter::REST::Client.new do | config |
  config.consumer_key        = ENV['consuTwitter']
  config.consumer_secret     = ENV['secretApp']
  config.access_token        = ENV['persoToken']
  config.access_token_secret = ENV['secretToken']
end

session = GoogleDrive::Session.from_config("config.json")



=begin
client.user_search('Cerfontaine').each do |allo|
  client.follow(allo)
  puts "follow #{allo.name}"
  sleep 3
end
=end

=begin
while 1
  client.create_direct_message("@lesflibusTHP", "salut les ptis loups")
  sleep 3 
end
=end

