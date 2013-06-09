class AddMoreinfoToStories < ActiveRecord::Migration
  def change
    add_column :stories, :more_info_url, :string
    add_column :stories, :more_info_title, :string
    add_column :stories, :more_info_description, :text
    add_column :stories, :more_info_notes, :text
  end
end
