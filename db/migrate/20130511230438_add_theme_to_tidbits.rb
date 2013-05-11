class AddThemeToTidbits < ActiveRecord::Migration
  def change
    add_column :tidbits, :collection_id, :integer, :default => 1
    add_column :tidbits, :theme_id, :integer
  end
end
