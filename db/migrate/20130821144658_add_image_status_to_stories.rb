class AddImageStatusToStories < ActiveRecord::Migration
  def change
    add_column :stories, :image_usage_cleared, :boolean, :default => false
    add_column :stories, :image_status_id, :integer, :default => 1
  end
end
