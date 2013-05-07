class CreateWorkflowStates < ActiveRecord::Migration
  def change
    create_table :workflow_states do |t|
      t.string :workflow_state

      t.timestamps
    end
  end
end
