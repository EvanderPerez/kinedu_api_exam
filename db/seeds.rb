puts 'Create Users'
Rake::Task['users:create'].invoke

puts 'Create Tasks'
Rake::Task['tasks:create'].invoke

