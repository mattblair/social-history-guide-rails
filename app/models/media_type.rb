# == Schema Information
#
# Table name: media_types
#
#  id         :integer          not null, primary key
#  human_name :string(255)
#  name       :string(255)
#  icon       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MediaType < ActiveRecord::Base
  
  has_many :tidbits
  has_many :stories
  
  attr_accessible :icon, :name, :human_name
  
  # added for ActiveAdmin select controls
  # probably a more eloquent way to put this...
  def to_s
    !human_name.empty? ? human_name : name.capitalize
  end
end
