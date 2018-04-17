
#utile si tu veux tester le fichier de maniere separé à app_final
#uncomment alors
=begin
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

session = GoogleDrive::Session.from_config("../config.json")
sheet = session.spreadsheet_by_key("1FTrYqyqsvrlciU5OjC7H6LvPbd0_kjdBrp93g7oOv4k").worksheets[0]
=end

def follow_townhall(sheet,client)
  index = 1

  while sheet[index,1] != ""

    premier_result = client.user_search(sheet[index,1])[0]
    client.follow(premier_result)
    puts "follow #{premier_result.name}"
    sleep 3
    index +=1
  end
end

#uncomment pour la correction 
#follow_townhall(sheet,client)

