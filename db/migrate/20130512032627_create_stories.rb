class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :subtitle
      t.text :summary
      t.string :audio_filename
      t.string :original_audio_filename
      t.string :image_name
      t.string :image_credit
      t.string :thumbnail_name
      t.string :twitter_template
      t.text :editorial_notes
      t.integer :editing_priority, :default => 50
      t.text :audio_transcription
      t.integer :display_order, :default => 50
      t.string :keywords
      t.float :latitude
      t.float :longitude
      
      t.references :workflow_state, :default => 1
      t.references :collection, :default => 1
      t.references :theme
      t.references :guest
      t.references :media_type, :default => 1
      
      t.timestamps
    end
  end
end
