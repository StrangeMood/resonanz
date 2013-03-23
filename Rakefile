# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Resonanz::Application.load_tasks

namespace :db do
  task :migrate => :environment do
    Rake::Task['db:schema:dump'].invoke
  end
end
