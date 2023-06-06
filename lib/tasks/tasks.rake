namespace :tasks do
  task create: :environment do
    Task.find_or_create_by(name: 'Bug 123: No se muestra logo',
                           description: 'Al iniciar sesión no se muestra el logo',
                           created_by_id: User.find_by(email: 'evanderperez@hotmail.com').id
                           )
  end
end
