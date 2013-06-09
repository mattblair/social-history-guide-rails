class AddPhotonotesToTidbits < ActiveRecord::Migration
  def change
    add_column :tidbits, :photo_notes, :text
    add_column :tidbits, :proofreader_id, :integer  # associated with admin_user
  end
end
