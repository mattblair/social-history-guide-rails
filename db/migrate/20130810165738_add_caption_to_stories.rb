class AddCaptionToStories < ActiveRecord::Migration
  def change
    add_column :stories, :image_caption, :string
    add_column :stories, :location_valid, :boolean, :default => 0
  end
end
