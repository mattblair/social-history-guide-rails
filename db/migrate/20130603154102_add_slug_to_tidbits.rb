class AddSlugToTidbits < ActiveRecord::Migration
  def change
    add_column :tidbits, :slug, :string
    add_index :tidbits, :slug, unique: true
  end
end
