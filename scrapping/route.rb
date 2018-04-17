require 'nokogiri'
require 'open-uri'


#cette fonction sert a recuperer l'email. grace à au chemin xpath 
#on sauvegarde à chaque changement pour que le correcteur vois bien l'avancement dans le fichier

def get_the_email(temporaire, nb, feuillu)
  puts temporaire.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text   # affichage de chaque email trouvé
  feuillu[nb,2] = temporaire.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text  #stockage dans le tableau
  feuillu.save
end

#cette fonction est là pour instancier chaque page et recuperer une partie des choses qu'ils nous faut

def get_all_the_urls(liens,feuille)                                  
  doc = Nokogiri::HTML(open(liens))           
  size = doc.css("a.lientxt").length        #recuperation de la taille du tableau contenant tout les liens
  index = 1
  while feuille[index,1] != ""              #on avance jusqu'a ce que la Worsheet soit vide
    index +=1
    puts feuille[index,1]
  end
  for n in 0...size
    tmp = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com#{doc.css("a.lientxt")[n]['href']}")) #ouvre chaque pages des mairies
    feuille[(n+index),1] = doc.css("a.lientxt")[n]['href'].tr("/", "").gsub(".html", "").tr(".", "").to_s #construction des noms des mairies
    feuille[(n+index),3] = feuille[(n+index),1][0,2] # recuperation departement
    feuille[(n+index),1] = feuille[(n+index),1].tr("1234678590","") #recuperation du nom de la ville departement
    feuille.save
    get_the_email(tmp, (n + index), feuille)            #appel de la fonction# à partir due l'url recuperé
  end
end

