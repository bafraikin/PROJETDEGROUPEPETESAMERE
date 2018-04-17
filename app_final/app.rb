require 'google_drive'
require 'gmail'
require_relative('../mailer/*')
require_relative('../scrapping/*')
require_relative('../twitter/*')

#d'abord on scrappe et on rempli la feuille excel

def app_final(client,urls,sheet)




end

#on a decidé de prendre le nord et ses 695 communes ainsi que la gironde, et le haut-rhin
url = []
url[0] = "http://annuaire-des-mairies.com/nord.html"
url[1] = "http://annuaire-des-mairies.com/nord-2.html"
url[2] = "http://annuaire-des-mairies.com/nord-3.html"
url[3] = "http://annuaire-des-mairies.com/haut-rhin.html"
url[4] = "http://annuaire-des-mairies.com/gironde.html"

#session pour la worksheet
session = GoogleDrive::Session.from_config("config.json")
sheet = session.spreadsheet_by_key("1FTrYqyqsvrlciU5OjC7H6LvPbd0_kjdBrp93g7oOv4k").worksheets[0]

#config pour twitter
client = Twitter::REST::Client.new do | config |
  config.consumer_key        = ENV['consuTwitter']
  config.consumer_secret     = ENV['secretApp']
  config.access_token        = ENV['persoToken']
  config.access_token_secret = ENV['secretToken']
end
#il reste une config à faire dans le mailer pour envoyer des mail


