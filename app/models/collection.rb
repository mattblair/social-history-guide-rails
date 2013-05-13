# == Schema Information
#
# Table name: collections
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  description         :text
#  author              :string(255)
#  geographical_title  :string(255)
#  geographical_scope  :text
#  latitude            :float
#  longitude           :float
#  published           :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  sponsor_name        :string(255)
#  sponsor_description :text
#  sponsor_logo_name   :string(255)
#  sponsor_url         :text
#  curator_name        :string(255)
#  curator_url         :text
#

class Collection < ActiveRecord::Base
  
  has_many :tidbits
  has_many :stories
  
  attr_accessible :author, :description, :geographical_scope, :geographical_title, :latitude, :longitude, :published, :title
end
