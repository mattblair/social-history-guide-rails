class ChangeWorkflowColumnNames < ActiveRecord::Migration
  def change
    rename_column :workflow_states, :workflow_state, :state_name
  end
end
