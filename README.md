# README
This project was made as an exam application for Kinedu by Evander Adrián Pérez Grijalva(me). on June 9 I will make the repository private

# Installation
This project is based on Ruby on Rails and Postgresql

# Installation steps
* $  git clone git@github.com:EvanderPerez/kinedu_api_exam.git
* $  bundle install
* $  rails db:create db:migrate db:seed
* $  rails s

# Project route
* The default server route is 'http://localhost:3000/'
* The swagger server route is 'http://localhost:3000/api-docs'
# Testing steps
* $ bundle exec rspec 

# How to use authentication on swagger
* 1.- Create an account on POST /api/v1/users.
* 2.- Put the user email and password on POST /api/v1/log_in, on the response you will receive the user_id and access-token, make sure you copy them.
* 3.- In any endpoint you want to use, put the access-token and user_id values on the header paramethers. 
* Just the GET and POST methods for User controller doesnt need permissions if you want to make tests

Maybe I spent too much hours than the necessary for this exam but it was a great exercise for me and I feel fine.
