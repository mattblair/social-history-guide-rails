class AddProofreaderToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :proofreader_id, :integer # associated with admin_user
  end
end
