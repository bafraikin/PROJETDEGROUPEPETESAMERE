require 'google_drive'
require 'gmail'
require 'dotenv'
require 'twitter'
Dotenv.load('../file.env')
load '../mailer/gauthiermailer.rb'
load '../scrapping/route.rb'
load '../twitter/follow.rb'

#d'abord on scrappe et on rempli la feuille excel

def app_final(client,urls,sheet)
  version = 0
  while version < 0 || version > 4
    version= get.chomp.to_i
  end

  if version == 1 
    urls.each do | url |
      get_all_the_urls(url,sheet)   #partis scrapping
    end
    go_through_all_the_lines(sheet)  #on envoit des mail aux emails qu'on a recuperer
    follow_townhall(client,sheet) # on follow les comptes de villes
  end

  if version == 2

  end
  if version == 3

  end
  if version == 4

  end
end


#on a decidé de prendre le nord et ses 695 communes ainsi que la gironde, et le haut-rhin
url = []
url[0] = "http://annuaire-des-mairies.com/nord.html"
url[1] = "http://annuaire-des-mairies.com/nord-2.html"
url[2] = "http://annuaire-des-mairies.com/nord-3.html"
url[3] = "http://annuaire-des-mairies.com/haut-rhin.html"
url[4] = "http://annuaire-des-mairies.com/gironde.html"

#session pour la worksheet
session = GoogleDrive::Session.from_config("../config.json")
sheet = session.spreadsheet_by_key("1wrkw4OuAZX9gH7J7A4qRbIhNXgbB0twXQBswYm5DM1w").worksheets[0]

#config pour twitter
client = Twitter::REST::Client.new do | config |
  config.consumer_key        = ENV['consuTwitter']
  config.consumer_secret     = ENV['secretApp']
  config.access_token        = ENV['persoToken']
  config.access_token_secret = ENV['secretToken']
end
#il reste une config à faire dans le mailer pour envoyer des mail

app_final(client, url, sheet)

