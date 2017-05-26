ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end
    columns do
      column do
        panel "Запросы на вывод денег" do
          table_for Getmoney.order('id desc').limit(10).each do |customer|
            column :user
            column :created_at
            column :desc
            column :total
            column :wallet
            column :walletfirm
            column :status
          end
        end
      end
    end

    columns do
      column do
        panel "Реферальные балансы пользователей" do
          table_for Transfer.order('id desc').limit(10).each do |customer|
            # column(:email)    {|customer| link_to(customer.email, admin_root_path(customer)) }
            column :user
            column :created_at
            column :summa
          end
        end
      end
    end

     columns do
      column do
        panel "Пользователи сайта" do
          table_for User.order('id desc').each do |customer|
            column(:email)    {|customer| link_to(customer.email, admin_user_path(customer)) }
            column :name
            column :level
            column :reffered
            column :carrier
            column :conductor
            column :balance
            column :created_at
            column :admin
          end
        end
      end

    end # columns

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

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end