ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end

    # end

    # table_for Note.order("created_at desc").limit(5) do
    #   column 'Recent Notes', :title do |note|
    #     link_to note.title, [:admin, note]
    #   end
    # end
    # strong { link_to "View All Notes", admin_notes_path }

    # table_for User.order("created_at desc").limit(5) do
    #   column 'Recently joined', :username do |user|
    #      link_to user.username, [:admin, user]
    #    end
    # end
    # strong { link_to "View All Users", admin_users_path}

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Notes" do
          ul do
          note  = Note.order("created_at desc").limit(5)
           note.each do |n|
             li link_to(n.title, admin_notes_path)
           end
          end
        end
      end
      column do
        panel "Recent Users" do
          ul do
          user  = User.order("created_at desc").limit(5)
           user.each do |u|
             li link_to(u.username, admin_users_path)
           end
          end
        end
      end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
     end
  end # content
end
