# Messaging Application 

I’m using Rails version 8.0, the Noticed gem version 2.6, and MySQL.

* It’s a simple application where users who are signed in can search for other users they want to message and communicate with them through text messages.

* I also added a notification feature so that when a user sends a message, the recipient gets a notification. However, this caused an error due to changes in the latest version of the Noticed gem.

* I tried creating a notifier using the command:
  
* rails g noticed:notifier MessageNotification ---> This command successfully created the notifier, but when I ran

* rails db:migrate  ---> no tables were added to the database.

* I’m not sure where I made a mistake. Could you please help me resolve this issue?
