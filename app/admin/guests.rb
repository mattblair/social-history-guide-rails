ActiveAdmin.register Guest do
  
  scope :proposed
  scope :draft
  scope :edited
  scope :published
  
  index do
      #column :name
      column "Name", :sortable => :name do |guest|
            link_to(guest.name, admin_guest_path(guest))
      end
      column :title
      column :specialty
      column "Last Updated", :updated_at
      
      default_actions
  end
  
end
