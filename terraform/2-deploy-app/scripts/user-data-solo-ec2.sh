#!/bin/bash

# Wait for everything to be ready - User Data runs very fast! 
sleep 15

# user data runs as root!
cd /home/ubuntu

# cd to correct folder
# CHANGE THIS TO YOURS
cd sparta-app-code

# npm install
sudo npm install

# seed database
node seeds/seed.js

# start app
pm2 start app.js