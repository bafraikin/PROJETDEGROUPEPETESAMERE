require 'nokogiri'
require 'open-uri'
require 'google_drive'


session = GoogleDrive::Session.from_config("config.json")

def get_the_email(temporaire, nb, feuillu)
  puts temporaire.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text   # affichage de chaque email trouvé
  feuillu[nb,2] = temporaire.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text  #stockage dans le tableau
  feuillu.save
end

def get_all_the_urls(liens,feuille)                                  #creation du tableau
  doc = Nokogiri::HTML(open(liens))
  size = doc.css("a.lientxt").length          #determiner l'etendu de ma boucle for
  index = 1
  while feuille[index,1] != ""
    index +=1
    puts feuille[index,1]
  end
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css("a.lientxt")[n]['href']}")) #ouvre chaque pages des mairies
    feuille[(n+index),1] = doc.css("a.lientxt")[n]['href'].tr("/95/", "").gsub(".html", "").tr(".", "").to_s #construction des noms des mairies
    feuille.save
    get_the_email_of_a_townhal_from_its_webpage(tmp, (n + index), feuille)   #appel de la fonction# à partir due l'url recuperé
  end
end



url = []
url[0] = "http://annuaire-des-mairies.com/nord.html"
url[1] = "http://annuaire-des-mairies.com/nord-2.html"
url[2] = "http://annuaire-des-mairies.com/nord-3.html"
url[3] = "http://annuaire-des-mairies.com/haut-rhin.html"
url[4] = "http://annuaire-des-mairies.com/gironde.html"

sheet = session.spreadsheet_by_key("1FTrYqyqsvrlciU5OjC7H6LvPbd0_kjdBrp93g7oOv4k").worksheets[0]

url.each do |urle|
  get_all_the_urls(urle,sheet)
  sheet.save
end



