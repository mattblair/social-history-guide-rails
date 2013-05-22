# == Schema Information
#
# Table name: workflow_states
#
#  id         :integer          not null, primary key
#  state_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WorkflowState < ActiveRecord::Base
  
  has_many :themes
  has_many :tidbits
  has_many :stories
  has_many :guests
  
  attr_accessible :state_name
  
  # added for ActiveAdmin select controls
  def to_s
    state_name.capitalize
  end
  
end
