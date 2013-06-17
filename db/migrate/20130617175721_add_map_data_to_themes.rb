class AddMapDataToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :map_data, :text
    add_column :themes, :map_data_type, :integer, :default => 0
    add_column :themes, :display_in_story_list, :boolean, :default => 1
    add_column :themes, :display_in_tidbit_list, :boolean, :default => 1
  end
end
