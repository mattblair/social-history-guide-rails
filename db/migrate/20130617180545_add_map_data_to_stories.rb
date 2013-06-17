class AddMapDataToStories < ActiveRecord::Migration
  def change
    add_column :stories, :map_data, :text
    add_column :stories, :map_data_type, :integer, :default => 0
  end
end
