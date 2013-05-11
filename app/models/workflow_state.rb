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
  
  attr_accessible :state_name
end
