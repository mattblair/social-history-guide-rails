class AddImageDetailsToTidbits < ActiveRecord::Migration
  def change
    add_column :tidbits, :image_credit_url, :text
    add_column :tidbits, :image_copyright_notice, :string
    add_column :tidbits, :image_copyright_url, :text
    add_column :tidbits, :image_copyright_details, :text
    add_column :tidbits, :media_copyright_notice, :string
    add_column :tidbits, :media_copyright_url, :text
    add_column :tidbits, :media_copyright_details, :text
  end
end
