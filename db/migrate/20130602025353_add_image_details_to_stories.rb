class AddImageDetailsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :image_credit_url, :text
    add_column :stories, :image_copyright_notice, :string
    add_column :stories, :image_copyright_url, :text
    add_column :stories, :image_copyright_details, :text
  end
end
