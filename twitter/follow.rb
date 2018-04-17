

# fonction qui va parcourir la worksheet
# lancer une recherche de user
# puis follow le 1er user qu'elle trouve

def follow_townhall(sheet,client)
  index = 1

  while sheet[index,1] != ""  #parcours la feuille

    premier_result = client.user_search(sheet[index,1])[0]   #search et recupere le 1er user trouvé
    if premier_result != nil 
      client.follow(premier_result)    #follow
    puts "follow #{premier_result.name}"  #affichage
    puts "sleep de 10 seconde" 
    sleep 10  #sleep pour permettre à twitter    
    index +=1
    end
  end
end

