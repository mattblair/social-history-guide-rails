class AddMoreinfoToTidbits < ActiveRecord::Migration
  def change
    add_column :tidbits, :more_info_url, :string
    add_column :tidbits, :more_info_title, :string
    add_column :tidbits, :more_info_description, :text
    add_column :tidbits, :more_info_notes, :text
  end
end
