class AddPhotonotesToStories < ActiveRecord::Migration
  def change
    add_column :stories, :photo_notes, :text
    add_column :stories, :proofreader_id, :integer # associated with admin_user
  end
end
