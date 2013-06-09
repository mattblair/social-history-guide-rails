class AddProofreaderToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :proofreader_id, :integer  # associated with admin_user
  end
end
