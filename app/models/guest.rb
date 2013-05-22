# == Schema Information
#
# Table name: guests
#
#  id                :integer          not null, primary key
#  name              :string(255)      default(""), not null
#  title             :string(255)
#  organization      :string(255)
#  image_name        :string(255)
#  bio               :text
#  twitter_template  :string(255)
#  editorial_notes   :text
#  quote             :text
#  guest_url         :string(255)
#  guest_url_text    :string(255)
#  workflow_state_id :integer          default(1)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  display_order     :integer          default(50)
#  specialty         :text
#

class Guest < ActiveRecord::Base
  
  belongs_to :workflow_state
  
  has_many :stories
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  
  scope :proposed, where(:workflow_state_id => 1)
  scope :draft, where(:workflow_state_id => 2)
  scope :edited, where(:workflow_state_id => 5)
  scope :published, where(:workflow_state_id => 6)
  
  attr_accessible :bio, :editorial_notes, :guest_url, :guest_url_text, :image_name, :name, :organization, :quote, :title, :twitter_template
end
