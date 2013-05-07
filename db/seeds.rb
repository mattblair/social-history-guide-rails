# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html

import 'json'

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

User.destroy_all

puts 'ADMIN USER'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin

puts 'PDX USERS'
# pbpaste | python -mjson.tool | pbcopy
records = JSON.parse(File.read(ENV['KYC_USER_JSON']))
records.each do |kyc_user|
  puts "Adding account for #{kyc_user['human_name']}"
  # use , without_protection: true to override attribute protection
  
  user = User.find_or_create_by_email :email => kyc_user['email']
  
  user.name = kyc_user['human_name']
  user.password = kyc_user['password']
  user.password_confirmation = kyc_user['password']
  
  # don't use this in production
  user.add_role :admin
  
  user.save
  
=begin
  fetched_role = Role.where( :name => kyc_user['role'] )
  puts "Role: #{fetched_role.name} for #{kyc_user['role']}"
  if fetched_role
    #user.add_role fetched_role
  else
    puts "Role #{kyc_user['role']} not defined."
  end
=end

end

puts 'COLLECTIONS'

collections = JSON.parse(File.read(ENV['KYC_COLLECTION_JSON']))
collections.each do |kyc_collection|
  puts "Adding collection object for #{kyc_collection['title']}"
  # use , without_protection: true to override attribute protection
  
  coll = Collection.find_or_create_by_title :title => kyc_collection['title'].dup, :description => kyc_collection['description'].dup, :author => kyc_collection['author'].dup, :geographical_title => kyc_collection['geographical_title'].dup
  
  coll.latitude = kyc_collection['latitude']
  coll.longitude = kyc_collection['longitude']
  coll.published = kyc_collection['published']
  
  coll.save
  
=begin
  fetched_role = Role.where( :name => kyc_user['role'] )
  puts "Role: #{fetched_role.name} for #{kyc_user['role']}"
  if fetched_role
    #user.add_role fetched_role
  else
    puts "Role #{kyc_user['role']} not defined."
  end
=end

end

puts 'THEMES'
# import from themes.json


puts 'GUESTS'
# import from kyc_users.json
