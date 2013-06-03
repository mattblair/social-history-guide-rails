class AddSlugToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :slug, :string
    add_index :themes, :slug, unique: true
  end
end
