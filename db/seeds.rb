# This file contains data for the May 2014 story entries
# The data can then be loaded with the rake db:seed
# for initial database setup, see seeds-original.rb

# Carye Bye
# Theme: 10
# Guest: 11

=begin
theme = 10
guest = 11
audio_names = ["cb-intro", "cb-ohs-exhibits-and-facade", "cb-pam", "cb-park-blocks", "cb-pcpa-mural", "cb-pdx-penny", "cb-police-museum", "cb-portlandia-"]


# Mike Lastra

theme = 11
guest = 14
audio_names = ["ml-intro", "ml-10th-and-everett", "ml-archive-snippet", "ml-bomb-threat-satyricon", "ml-earth-tavern", "ml-nw-service-center", "ml-quality-pie-and-nw-spirit"]

# Steve Dotterer
theme = 18
guest = 13
audio_names = ["sd-intro", "sd-exterior-and-clocktower", "sd-lobby", "sd-pietro-belluschi", "sd-plans-over-time", "sd-railways-as-natl-connection", "sd-station-construction", "sd-working-class-african-american"]

=end

# Suenn Ho
theme = 12
guest = 12

audio_names = ["sh-intro", "sh-back-of-lilly-plaque", "sh-cherry-davis-and-3rd", "sh-elephant", "sh-gourd-3rd-and-davis", "sh-lilly-couch-and-4th", "sh-lotus-4th-and-couch", "sh-project-explanation"]



# switch title to filename[3..-1] ? 
#but it won't create the multiple intro ones without the prefix

audio_names.each do |filename|

  story = Story.find_or_create_by_title :title => filename, :original_audio_filename => filename, :audio_filename => filename

  story.slug = filename
  story.summary = ""
  story.subtitle = ""
  story.image_status_id = 1
  story.display_order = filename.end_with?("intro") ? 1 : 10
  story.theme_id = theme
  story.guest_id = guest
  story.collection_id = 1
  story.workflow_state_id = 2
  
  story.save
  
end