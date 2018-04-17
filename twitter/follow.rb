
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

