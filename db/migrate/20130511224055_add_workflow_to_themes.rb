class AddWorkflowToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :workflow_state_id, :integer, :default => 1
  end
end
