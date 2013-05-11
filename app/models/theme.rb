# == Schema Information
#
# Table name: themes
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  subtitle         :string(255)
#  summary          :text
#  image_name       :string(255)
#  image_credit     :string(255)
#  twitter_template :string(255)
#  editorial_notes  :text
#  latitude         :float
#  longitude        :float
#  display_order    :integer
#  keywords         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Theme < ActiveRecord::Base
  
  belongs_to :workflow_state
  
  delegate :state_name, :to => :workflow_state
  
  attr_accessible :display_order, :editorial_notes, :image_credit, :image_name, :keywords, :latitude, :longitude, :subtitle, :summary, :title, :twitter_template
end
