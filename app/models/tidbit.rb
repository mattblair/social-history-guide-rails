class Tidbit < ActiveRecord::Base
  attr_accessible :audio_filename, :body, :editorial_notes, :image_caption, :image_credit, :image_name, :latitude, :longitude, :publication_date, :source, :source_url, :title, :twitter_template, :year
end
