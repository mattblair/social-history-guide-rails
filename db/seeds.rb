# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html


# validate json files in advance:
# pbpaste | python -mjson.tool | pbcopy
# there's probably a ruby way to do this...


import 'json'

puts 'Populating ROLES --------------------------------------'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'Added role: ' << role
end

puts 'Populating WORKFLOW -----------------------------------'
YAML.load(ENV['WORKFLOW_STATES']).each do |state|
  WorkflowState.find_or_create_by_state_name({ :state_name => state }, :without_protection => true)
  puts 'Added workflow state: ' << state
end

puts 'Populating MEDIA TYPES --------------------------------'
YAML.load(ENV['MEDIA_TYPES']).each do |name|
  MediaType.find_or_create_by_name({ :name => name }, :without_protection => true)
  puts 'Added media type: ' << name
end

# Clear out user list, if needed
User.destroy_all

puts 'Creating ADMIN USER -----------------------------------'

# create admin as a preview user
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin

# create placeholder admin user
admin_user = AdminUser.find_or_create_by_email :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup

admin_user.save

# generate all admin accounts listed in JSON

admin_team = JSON.parse(File.read(ENV['KYC_ADMIN_USER_JSON']))
admin_team.each do |kyc_admin_user|
  puts "Adding admin account for #{kyc_admin_user['human_name']}"
  # use , without_protection: true to override attribute protection
  
  a_user = AdminUser.find_or_create_by_email :email => kyc_admin_user['email']
  
  a_user.human_name = kyc_admin_user['human_name']
  a_user.username = kyc_admin_user['username']
  a_user.password = kyc_admin_user['password']
  a_user.password_confirmation = kyc_admin_user['password']
  
  # use specific role:
  fetched_role = Role.where( :name => kyc_admin_user['role'] )
  puts "Role: #{fetched_role.name} for #{kyc_admin_user['role']}"
  if fetched_role
    a_user.roles << fetched_role
  else
    puts "Role #{kyc_admin_user['role']} not defined."
  end
  
  a_user.save
  
  # not showing errors yet. Test: use a password < 8 characters
  a_user.errors do |error|
    puts "Error saving account for #{kyc_admin_user['human_name']}: #{error.messages}"
  end
end


puts 'Adding PREVIEW USERS ----------------------------------'
records = JSON.parse(File.read(ENV['KYC_USER_JSON']))
records.each do |kyc_user|
  puts "Adding account for #{kyc_user['human_name']}"
  # use , without_protection: true to override attribute protection
  
  user = User.find_or_create_by_email :email => kyc_user['email']
  
  user.name = kyc_user['human_name']
  user.password = kyc_user['password']
  user.password_confirmation = kyc_user['password']
  
  # use specific role:
  fetched_role = Role.where( :name => kyc_user['role'] )
  puts "Role: #{fetched_role.name} for #{kyc_user['role']}"
  if fetched_role
    user.roles << fetched_role
  else
    puts "Role #{kyc_user['role']} not defined."
  end
  
  user.save
  
  # not showing errors yet. Test: use a password < 8 characters
  user.errors do |error|
    puts "Error saving account for #{kyc_user['human_name']}: #{error.messages}"
  end
end

puts 'Populating COLLECTIONS --------------------------------'

collections = JSON.parse(File.read(ENV['KYC_COLLECTION_JSON']))
collections.each do |kyc_collection|
  puts "Adding collection object for #{kyc_collection['title']}"
  # use , without_protection: true to override attribute protection
  
  coll = Collection.find_or_create_by_title :title => kyc_collection['title'].dup, :description => kyc_collection['description'].dup, :author => kyc_collection['author'].dup, :geographical_title => kyc_collection['geographical_title'].dup
  
  coll.latitude = kyc_collection['latitude']
  coll.longitude = kyc_collection['longitude']
  coll.published = kyc_collection['published']
  
  coll.save

end

puts 'Populating THEMES -------------------------------------'
# import from themes.json

themes = JSON.parse(File.read(ENV['KYC_THEMES_JSON']))
themes.each do |kyc_theme|
  
  puts "Adding theme object for #{kyc_theme['title']}"
  
  theme = Theme.find_or_create_by_title :title => kyc_theme['title'], :summary => kyc_theme['summary'], :image_name => kyc_theme['image_name'], :subtitle => kyc_theme['subtitle']
  
  theme.latitude = kyc_theme['latitude']
  theme.longitude = kyc_theme['longitude']
  theme.workflow_state_id = kyc_theme['workflow_state_id']
  
  # this defaults to true
  if kyc_theme['display_in_story_list']
    theme.display_in_story_list = kyc_theme['display_in_story_list']
  end
  
  theme.save
  
end

puts 'Populating GUESTS -------------------------------------'

guests = JSON.parse(File.read(ENV['KYC_GUESTS_JSON']))
guests.each do |kyc_guest|
  
  puts "Adding guest object for #{kyc_guest['name']}"
  
  guest = Guest.find_or_create_by_name :name => kyc_guest['name'], :organization => kyc_guest['organization'], :bio => kyc_guest['bio']
  
  guest.image_name = kyc_guest['image_name']
  guest.quote = kyc_guest['quote']
  guest.specialty = kyc_guest['specialty']
  guest.title = kyc_guest['title']
  guest.display_order = kyc_guest['display_order']
  
  guest.save
  
end

puts 'Populating STORIES ------------------------------------'

stories = JSON.parse(File.read(ENV['KYC_STORIES_JSON']))
stories.each do |kyc_story|
  
  if !kyc_story['title'].empty?
    
    puts "Adding story object for #{kyc_story['title']}"

    story = Story.find_or_create_by_title :title => kyc_story['title'], :original_audio_filename => kyc_story['original_audio_filename'], :audio_filename => kyc_story['audio_filename']

    story.summary = kyc_story['summary']
    story.subtitle = kyc_story['subtitle']
    story.display_order = kyc_story['display_order']
    story.theme_id = kyc_story['theme_id']
    story.guest_id = kyc_story['guest_id']
    story.latitude = kyc_story['latitude']
    story.longitude = kyc_story['longitude']
    story.editing_priority = kyc_story['editing_priority']
    story.editorial_notes = kyc_story['editorial_notes']

    story.save
    
  end
end

puts 'Populating TIDBITS ------------------------------------'

tidbits = JSON.parse(File.read(ENV['KYC_TIDBITS_JSON']))
tidbits.each do |kyc_tidbit|
  
  if !kyc_tidbit['title'].empty?
    
    puts "Adding tidbit object for #{kyc_tidbit['title']}"

    tidbit = Tidbit.find_or_create_by_title :title => kyc_tidbit['title']

    tidbit.body = kyc_tidbit['body']
    tidbit.publication_date = kyc_tidbit['publication_date']
    tidbit.latitude = kyc_tidbit['latitude']
    tidbit.longitude = kyc_tidbit['longitude']
    tidbit.theme_id = kyc_tidbit['theme_id']
    tidbit.slug = kyc_tidbit['slug']
    tidbit.editorial_notes = kyc_tidbit['editorial_notes']
    tidbit.workflow_state_id = kyc_tidbit['workflow_state_id']
    tidbit.media_type_id = kyc_tidbit['media_type_id']

    tidbit.save
    
  end
end
