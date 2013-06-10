class AddNameToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :human_name, :string
    add_column :admin_users, :username, :string
  end
end
