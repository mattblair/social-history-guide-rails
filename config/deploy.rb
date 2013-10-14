# https://github.com/capistrano/capistrano/wiki/2.x-Significant-Configuration-Variables

# require 'bundler/capistrano'

set :application, "kyc-portland-beta"
set :scm, :git

# or https://username@github.com/username/railsapp.git
set :repository,  "git@github.com:mattblair/kyc-web-dev.git"

# tips via: https://help.github.com/articles/deploying-with-capistrano

# for branch support in the future:
# set :branch, "master"

# to prevent a full clone each time:
# set :deploy_via, :remote_cache

set :deploy_to, "/home/ewmedia/webapps/kyc130624"

server "web91.webfaction.com", :app, :web, :db, :primary => true

set :user, "ewmedia"
set :scm_username, "mattblair"
set :ssh_options, { :forward_agent => true }
# set :scm_password, ""

# recommended by WF docs
set :use_sudo, false
default_run_options[:pty] = true

# see gist below

# directory served by static server
set :assets_path, "/home/ewmedia/webapps/kycstatic/"
set :photos_path, "/home/ewmedia/webapps/kycstatic/photos/"
set :domain, "#{user}@web91.webfaction.com"
set :config_path, "#{deploy_to}/current/config/"
set :prod_db_path, "#{deploy_to}/current/db/production.sqlite3"

set :db_archive_path, "#{ENV['HOME']}/Dropbox/appWorkingNotes/knowYourCity/dbBackups"
set :json_archive_path, "#{ENV['HOME']}/Dropbox/appWorkingNotes/knowYourCity/jsonBackups"
set :photo_source_path, "#{ENV['HOME']}/Dropbox/appWorkingNotes/knowYourCity/webPhotos/"

set :app_db_path, "#{ENV['HOME']}/Documents/codeProjects/knowYourCity/knowYourCity/Resources/datastores/shg-web.sqlite"

# to generate photos at all needed sizes before rsync
set :photo_scaling_script, "#{ENV['HOME']}/Documents/codeProjects/knowYourCity/contentScripts/kyc-scale-photos.rb"

require 'time'

def archive_timestamp 
  # 8601 uses colons for time. Replace to make it filesystem-friendlier.
  return Time.now.utc.iso8601.gsub(":","-")
end

namespace :archive do
  desc 'Save the current data as JSON'
  task :json_files, :roles => :web do
    # make a timestamped folder in json_archive_path
    
    json_dir = "#{json_archive_path}/#{archive_timestamp}"
    
    Dir.mkdir(json_dir)
    
    prod_url = "https://kyc-beta.elsewiseapps.com"
        
    models_to_fetch = ["themes", "guests", "stories", "tidbits"]
    
    models_to_fetch.each do |model_name|
      
      # Example that works at the command line.
      # curl https://kyc-beta.elsewiseapps.com/tidbits.json --insecure -o ./tidbits.json
      # will require authentication in the future to get unpublished content
      # fails when called this way, with the message: "No such file or directory"
      # use Net::HTTP instead?
      %x{"curl #{prod_url}/#{model_name}.json --insecure -o #{json_dir}/#{model_name}.json"}
      
    end
  end
  
  desc 'Save the production database to the local dev machine'
  task :db, :roles => :db do
    
    archived_db = "#{db_archive_path}/production#{archive_timestamp}.sqlite3"
    puts %x{rsync --times --rsh=ssh --human-readable --progress #{domain}:#{prod_db_path} #{archived_db} }
    puts %x{cp #{archived_db} #{app_db_path} }
  end
  
end


namespace :deploy do
  desc "Restart nginx"
  task :restart do
    run "#{deploy_to}/bin/restart"
  end
  
  desc "Upload private files not in git"
  task :pushprivate do
    puts %x{rsync --times --rsh=ssh --human-readable --progress config/application.yml #{domain}:#{config_path}}
    puts %x{rsync --times --rsh=ssh --human-readable --progress config/database.yml #{domain}:#{config_path}}
  end
  
  desc "Upload photos to static photos directory"
  task :push_photos do
    # could also call kyc-scale-photos.rb here to generate the latest set of photos
    # :photo_scaling_script
    %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress #{photo_source_path} #{domain}:#{photos_path}}
  end
end

# via https://gist.github.com/andrik/3609935

namespace :assets do
  desc 'Run the precompile task locally and rsync with static server'
  task :precompile, :roles => :web, :except => { :no_release => true } do
    %x{bundle exec rake assets:precompile}
    %x{rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/assets #{domain}:#{assets_path}}
    %x{bundle exec rake assets:clean}
  end
end

#after "deploy", "assets:precompile"
#after "deploy", "deploy:pushprivate"
# then restart 


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end