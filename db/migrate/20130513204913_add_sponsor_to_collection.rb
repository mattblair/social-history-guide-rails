class AddSponsorToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :sponsor_name, :string
    add_column :collections, :sponsor_description, :text
    add_column :collections, :sponsor_logo_name, :string 
    add_column :collections, :sponsor_url, :text
    
    add_column :collections, :curator_name, :string
    add_column :collections, :curator_url, :text
    
  end
end
