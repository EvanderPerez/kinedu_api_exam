namespace :users do
  task create: :environment do
    User.find_or_create_by(email: 'evanderperez@hotmail.com',
                           password: 'pass123',
                           first_name: 'Evander',
                           last_name: 'Pérez'
                           )
  end
end
