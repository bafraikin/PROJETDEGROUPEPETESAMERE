require 'dotenv'
Dotenv.load('../file.env') 
require 'gmail'
require "google_drive"

def send_email_to_line(i) # méthode pour envoyer le mail à la ligne i de notre google spreadsheet
	Gmail.connect(ENV['User'], ENV['Pwd']) do |gmail| #connexion à mon compte gmail via file.env

	session = GoogleDrive::Session.from_config("config.json") #connexion à ma google spreadhseet via config.json
	ws = session.spreadsheet_by_key("1w7b3mU6STnnuPWLkjBX4h_5Bb4AE0pYJSg6lWW6zelo").worksheets[0]

	name = "Gauthier" # mon nom qui apparaît dans le corps du mail
	nom_commune = ws[i,1] #nom de la commune pour pouvoir l'appeler dans le corps du mail
	dep = ws[i,3] #numéro du département pour l'appeler dans le corps du mail
	
	gmail.deliver do #envoi du mail
  		to ws[i,2] # envoi à l'adresse contenue dans la 2e colonne
  		subject "The hacking project: l'éducation 2.0 pour tous"
  		
  		html_part do
   		 	content_type 'text/html; charset=UTF-8'
    		body "<p>Bonjour,</p><br/> <p>Je m'appelle #{name}, je suis élève à <strong>The Hacking Project</strong>, une formation au code <strong>gratuite, sans locaux, sans sélection, sans restriction géographique</strong>.<br/> La pédagogie de notre école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code.<br/> Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.</p> <br/>
<p>Déjà 300 personnes sont passées par The Hacking Project.</p> <br/> <p>Est-ce que la mairie de #{nom_commune} veut changer le monde avec nous ?</p> <p>Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80</p> <br/> <p> Profitez bien des beaux jours qui arrivent, j'espère qu'il fait beau dans le #{dep}! </p>"
  		end
	end

	end
end

def go_through_all_the_lines #méthode pour envoyer le mail à toutes les lignes de notre Google spreadsheet
	for a in 1..5 do #chiffre max foireux
		send_email_to_line(a) #envoie le mail à chaque ligne
	end
end

go_through_all_the_lines

