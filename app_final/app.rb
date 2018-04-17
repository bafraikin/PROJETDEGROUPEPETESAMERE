require 'google_drive'
require 'gmail'
require 'dotenv'
require 'twitter'
Dotenv.load('../file.env')
load '../mailer/gauthiermailer.rb'
load '../scrapping/route.rb'
load '../twitter/follow.rb'

#d'abord on scrappe et on rempli la feuille excel

def app_final(client,urls,sheet,gmail)
  version = 0

  while version < 1 || version > 4
    puts "\n\n"
    puts "On vous laisse le choix, ici vous pouvez choisir quelle partie de l'app vous appliquez"
    puts "1:  Vous lancez le processus normal, avec le scrapping, l'envoie de mail, et les follows"
    puts "2:  Vous lancez le scrapping, initié une feuille vide est recommandé"
    puts "3:  Vous lancez twitter et les follows, initié une worksheet pleine est conseillé"
    puts "4:  Vous lancez l'envoie de mail, initié une worksheet pleine est conseillé"
    puts "\n"
    print "faites votre choix ici : " 
    version= gets.chomp.to_i
  end

  if version == 1 
    urls.each do | url |
      get_all_the_urls(url,sheet)   #partis scrapping
    end
    go_through_all_the_lines(sheet, gmail)  #on envoit des mail aux emails qu'on a recuperer
    follow_townhall(sheet,client) # on follow les comptes de villes
  end

  if version == 2
    urls.each do | url |   #partis scrapping
get_all_the_urls(url,sheet)  #fournir une feuille vide
    end
  end

  if version == 3                 #version twitter    
    follow_townhall(sheet,client) # follow les comptes
  end                             #ne pas fournir une feuille vide    

  if version == 4  
    go_through_all_the_lines(sheet, gmail) #envoi des mails
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
#ne pas donner une worksheet vide pour la version 3
session = GoogleDrive::Session.from_config("../config.json")
sheet = session.spreadsheet_by_key("1FTrYqyqsvrlciU5OjC7H6LvPbd0_kjdBrp93g7oOv4k").worksheets[0]

#paramètre pour Gmail
gmail = Gmail.connect(ENV['User'], ENV['Pwd'])

#config pour twitter
client = Twitter::REST::Client.new do | config |
  config.consumer_key        = ENV['consuTwitter']
  config.consumer_secret     = ENV['secretApp']
  config.access_token        = ENV['persoToken']
  config.access_token_secret = ENV['secretToken']
end
#il reste une config à faire dans le mailer pour envoyer des mail
app_final(client, url, sheet, gmail)

