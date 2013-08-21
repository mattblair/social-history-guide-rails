class ImageStatus < ActiveRecord::Base
  
  has_many :stories
  
  attr_accessible :human_name, :name
end
