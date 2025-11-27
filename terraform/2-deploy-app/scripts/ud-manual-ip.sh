#!/bin/bash

# Wait for everything to be ready - User Data runs very fast! 
sleep 15

# user data runs as root!
cd /home/ubuntu

# cd to correct folder
# CHANGE THIS TO YOURS
cd sparta-app-code

# DB connection env var
# CHANGE THIS TO YOURS
export DB_HOST=mongodb://3.249.92.92:27017/posts

# npm install
sudo npm install

# seed database
node seeds/seed.js

# start app
pm2 start app.js