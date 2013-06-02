class AddImageDetailsToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :image_credit, :string
    add_column :guests, :image_credit_url, :text
    add_column :guests, :image_copyright_notice, :string
    add_column :guests, :image_copyright_url, :text
    add_column :guests, :image_copyright_details, :text
    add_column :guests, :release_confirmed, :boolean, :default => 0
  end
end
