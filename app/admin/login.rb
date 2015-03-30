ActiveAdmin.register UserLogin do
  config.batch_actions = false
  config.sort_order = 'created_at_desc'

  filter :ip, as: :string
  filter :user_agent
  filter :created_at
  filter :country
  filter :city

  # In order to hack the heroku issue with collations
  # We're sorting in rails and not on the DB level
  filter :user, collection: proc { User.all.sort_by { |u| u.first_name.downcase } }

  index do
    column(:user, sortable: "users.last_name") do |login|
      link_to login.user.full_name, admin_user_path(login.user)
    end
    column :ip
    column :user_agent
    column :country
    column :city
    column(:date, sortable: "created_at") do |login|
      login.created_at
    end
    column(:filter) do |login|
      link_to(I18n.t("messages.filters.this_user", default: "Filter by this user"),
        admin_logins_path({ q: { user_id_eq: login.user.id } }))
    end
  end

  controller do
    def scoped_collection
      super.includes :user # prevents N+1 queries to your database
    end
  end

end
