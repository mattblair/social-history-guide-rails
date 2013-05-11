# == Schema Information
#
# Table name: tidbits
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  year              :string(255)
#  publication_date  :datetime
#  twitter_template  :string(255)
#  latitude          :float
#  longitude         :float
#  editorial_notes   :text
#  image_name        :string(255)
#  image_caption     :string(255)
#  image_credit      :string(255)
#  body              :text
#  audio_filename    :string(255)
#  source            :string(255)
#  source_url        :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  workflow_state_id :integer          default(1)
#  media_type_id     :integer          default(3)
#

class Tidbit < ActiveRecord::Base
  
  belongs_to :workflow_state
  belongs_to :media_type
  
  belongs_to :collection
  belongs_to :theme
  
  delegate :state_name, :to => :workflow_state
  
  attr_accessible :audio_filename, :body, :editorial_notes, :image_caption, :image_credit, :image_name, :latitude, :longitude, :publication_date, :source, :source_url, :title, :twitter_template, :year
end
