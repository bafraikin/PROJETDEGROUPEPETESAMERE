require 'rubygems'
require 'nokogiri'   
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	page.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end
#puts get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")
#Pour vérifier la méthode, enlever le "#" de la ligne au dessus

def get_all_the_urls_of_val_doise_townhalls(url)
	page = Nokogiri::HTML(open(url))
	page.css("a.lientxt").each do |uairaile|
		puts uairaile["href"]
	end
end
#puts get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html")
#Pour vérifier la méthode, enlever le "#" de la ligne au dessus


#BONUS
def gets_all_the_motherfucking_mail_adresses_of_townhalls(url)
	 page = Nokogiri::HTML(open(url))
	 new_hash = Hash.new
	 new_hash = {}
	 page.css("a.lientxt").each do |townhall|
	 	liencomplet = "http://annuaire-des-mairies.com" + townhall["href"]
	 	nomville = townhall.text
	 	new_hash[nomville] = get_the_email_of_a_townhal_from_its_webpage(liencomplet)
	
	 end
	puts new_hash 

end
puts gets_all_the_motherfucking_mail_adresses_of_townhalls("http://www.annuaire-des-mairies.com/cotes-d-armor.html")
#Pour vérifier la méthode, enlever le "#" de la ligne au dessus




