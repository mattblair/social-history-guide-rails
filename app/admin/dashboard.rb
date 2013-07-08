ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    #div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #  span :class => "blank_slate" do
    #    span I18n.t("active_admin.dashboard_welcome.welcome")
    #    small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #  end
    #end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    columns do
      column do
        panel "Draft Stories" do
          ul do
            Story.where("workflow_state_id = 2").order("updated_at desc").limit(40).map do |story|
              li link_to(story.title, admin_story_path(story))
            end
          end
        end
      end
    end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
    
  end # content
  
  # include a sidebar directly:
=begin
  sidebar :help do
      ul do
        li "Second List First Item"
        li "Second List Second Item"
      end
  end
=end

  # or with a partial:
  sidebar :research_resources, :partial => "admin/resource/research_sidebar"
  sidebar :relevant_twitter_accounts, :partial => "admin/resource/historical_twitter"
  sidebar :other_resources, :partial => "admin/resource/other_sidebar"
  sidebar :launch_checklist, :partial => "admin/resource/launch_checklist"

end
