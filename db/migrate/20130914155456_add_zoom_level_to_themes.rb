class AddZoomLevelToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :zoom_level, :integer, :default => 12
  end
end
