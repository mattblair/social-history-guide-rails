class MediaType < ActiveRecord::Base
  
  has_many :tidbits
  
  attr_accessible :icon, :name, :type
end
