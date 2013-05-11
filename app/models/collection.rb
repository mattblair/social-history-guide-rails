# == Schema Information
#
# Table name: collections
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text
#  author             :string(255)
#  geographical_title :string(255)
#  geographical_scope :text
#  latitude           :float
#  longitude          :float
#  published          :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Collection < ActiveRecord::Base
  
  has_many :tidbits
  
  attr_accessible :author, :description, :geographical_scope, :geographical_title, :latitude, :longitude, :published, :title
end
