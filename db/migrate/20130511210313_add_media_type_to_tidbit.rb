class AddMediaTypeToTidbit < ActiveRecord::Migration
  def change
    add_column :tidbits, :media_type_id, :integer, :default => 3 # text
  end
end
