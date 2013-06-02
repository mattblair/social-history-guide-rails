ActiveAdmin.register Guest do
  
  menu :priority => 2
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  scope :proposed
  scope :draft
  scope :deferred
  scope :incomplete
  scope :edited
  scope :published
  scope :testing # only show to admin?
  
  filter :name
  filter :specialty
  
  index do
      column "Name", :sortable => :name do |guest|
            link_to(guest.name, admin_guest_path(guest))
      end
      column :title
      column :specialty
      column "Last Updated", :updated_at
      
      # only show edit in the right column:
      actions :defaults => false do |guest|
        link_to "Edit", edit_admin_guest_path(guest), :class => "member_link"
      end
  end
  
  form do |f|                         
    f.inputs "Basic Information" do       
      f.input :name
      f.input :title
      f.input :organization
      f.input :specialty, :input_html => {:rows => 1, :cols => 60}
      f.input :image_name
      #f.input :image_credit
      f.input :bio, :hint => "Up to 250 words", :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
      f.input :twitter_template, :label => "Twitter Text", :input_html => { :rows => 3, :cols => 20, :maxlength => 120 }, :hint => "Less than 120 characters, to leave space for urls, RTs, etc."
    end
    f.inputs "Additional Information" do 
      f.input :quote, :required => false, :input_html => { :class => 'autogrow', :rows => 10, :cols => 60  }
      f.input :guest_url_text, :hint => "The text to show as a link"
      f.input :guest_url, :hint => "The actual web address"
    end
    f.inputs "Editorial Details" do
      f.input :editorial_notes, :label => "Notes"
      f.input :workflow_state
      f.input :display_order
      #f.input :release_confirmed
    end                          
    f.actions
  end
  
end
