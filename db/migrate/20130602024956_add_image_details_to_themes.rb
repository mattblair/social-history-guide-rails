class AddImageDetailsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :image_credit_url, :text
    add_column :themes, :image_copyright_notice, :string
    add_column :themes, :image_copyright_url, :text
    add_column :themes, :image_copyright_details, :text
  end
end
