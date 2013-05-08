class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :title
      t.string :subtitle
      t.text :summary
      t.string :image_name
      t.string :image_credit
      t.string :twitter_template
      t.text :editorial_notes
      t.float :latitude
      t.float :longitude
      t.integer :displayOrder
      t.string :keywords

      t.timestamps
    end
  end
end
