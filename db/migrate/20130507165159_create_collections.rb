class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title
      t.text :description
      t.string :author
      t.string :geographical_title
      t.text :geographical_scope
      t.float :latitude
      t.float :longitude
      t.boolean :published

      t.timestamps
    end
  end
end
