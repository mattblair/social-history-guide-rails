class AddKeywordsToTidbits < ActiveRecord::Migration
  def change
    add_column :tidbits, :keywords, :string
    add_column :tidbits, :image_usage_cleared, :boolean, :default => false
    add_column :tidbits, :image_status_id, :integer, :default => 1
  end
end
