class ChangeMediaTypeColumnNames < ActiveRecord::Migration
  def change
    
    # get rid of type, which is reserved.
    # human_name could be used for a display name, if needed.
    rename_column :media_types, :type, :human_name
  
  end

end
