require 'dotenv'
Dotenv.load('../file.env') 
require 'gmail'
require "google_drive"

def send_email_to_line(i,ws,gmail) # méthode pour envoyer le mail à la ligne i de notre google spreadsheet
  #Gmail.connect(ENV['User'], ENV['Pwd']) do |gmail| #connexion à mon compte gmail via file.env 

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
    puts "email envoyé à #{ws[i,2]}"
  end
end

def go_through_all_the_lines(ws, gmail) #méthode pour envoyer le mail à toutes les lignes de notre Google spreadsheet

  i = 1
  until ws[i,1] == "" do #lorsqu'on sera arrivé au bout du tableau

    unless ws[i, 2] == "" #on envoit pas de mail si la mairie n'a pas renseigné son mail dans l'annuaire.
    send_email_to_line(i,ws, gmail) #envoie le mail à chaque ligne
    end
    i += 1
  end
end

#uncomment pour la correction
=begin
session = GoogleDrive::Session.from_config("../config.json") #connexion à ma google spreadhseet via config.json
w_sheet = session.spreadsheet_by_key("1FTrYqyqsvrlciU5OjC7H6LvPbd0_kjdBrp93g7oOv4k").worksheets[0]
 go_through_all_the_lines(w_sheet)
=end



