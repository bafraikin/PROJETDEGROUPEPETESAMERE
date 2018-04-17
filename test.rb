require 'googleauth'
require 'google_drive'
require 'gmail'
require 'dotenv'
Dotenv.load('../file.env')




gmail = Gmail.connect(ENV['User'], ENV['Pwd'])

puts gmail.inbox.count
gmail.logout
