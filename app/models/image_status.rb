class ImageStatus < ActiveRecord::Base
  
  has_many :stories
  has_many :tidbits
  
  attr_accessible :human_name, :name
end
