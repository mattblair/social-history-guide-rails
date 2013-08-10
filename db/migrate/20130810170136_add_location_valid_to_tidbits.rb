class AddLocationValidToTidbits < ActiveRecord::Migration
  def change
    add_column :tidbits, :location_valid, :boolean, :default => 0
  end
end
