class WorkflowState < ActiveRecord::Base
  
  has_many :tidbits
  
  attr_accessible :state_name
end
