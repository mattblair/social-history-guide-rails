class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name, :null => false, :default => ""
      t.string :title
      t.string :organization
      t.string :image_name
      t.text :bio
      t.string :twitter_template
      t.text :editorial_notes
      t.text :quote
      t.string :guest_url
      t.string :guest_url_text
      t.references :workflow_state, :default => 1

      t.timestamps
    end
  end
end
