class Theme < ActiveRecord::Base
  attr_accessible :displayOrder, :editorial_notes, :image_credit, :image_name, :keywords, :latitude, :longitude, :subtitle, :summary, :title, :twitter_template
end
