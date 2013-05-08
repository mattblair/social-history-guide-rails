class CreateTidbits < ActiveRecord::Migration
  def change
    create_table :tidbits do |t|
      t.string :title
      t.string :year
      t.datetime :publication_date
      t.string :twitter_template
      t.float :latitude
      t.float :longitude
      t.text :editorial_notes
      t.string :image_name
      t.string :image_caption
      t.string :image_credit
      t.text :body
      t.string :audio_filename
      t.string :source
      t.text :source_url

      t.timestamps
    end
  end
end
