# == Schema Information
#
# Table name: image_statuses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  human_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImageStatus < ActiveRecord::Base
  
  has_many :stories
  has_many :tidbits
  
  attr_accessible :human_name, :name
  
  def to_s
    human_name.empty? ? name.capitalize : human_name
  end
  
end
