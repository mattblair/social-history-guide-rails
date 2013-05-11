class AddWorkflowStateToTidbit < ActiveRecord::Migration
  def change
    add_column :tidbits, :workflow_state_id, :integer, :default => 1
  end
end
