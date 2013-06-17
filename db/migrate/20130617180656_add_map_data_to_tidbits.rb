class AddMapDataToTidbits < ActiveRecord::Migration
  def change
    add_column :tidbits, :map_data, :text
    add_column :tidbits, :map_data_type, :integer, :default => 0
  end
end
