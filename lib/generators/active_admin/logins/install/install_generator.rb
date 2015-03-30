require 'rails/generators'
require 'rails/generators/migration'

module ActiveAdmin
  module Logins
    module Generators
      class InstallGenerator < Rails::Generators::Base
        include Rails::Generators::Migration

        desc "Generates the necessary migrations and routes"

        source_root File.expand_path("../templates", __FILE__)

        def create_user_login_file
          create_file "app/admin/user_login.rb" do
            %Q{
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

            }
          end
        end

        def inject_into_user_model
          inject_into_file 'app/models/user.rb', after: "class User < ActiveRecord::Base\n" do <<-'RUBY'

  has_many :user_logins, dependent: :destroy

  def update_tracked_fields!(request)
    super
    UserLoginWorker.perform_async(self.id, request.remote_ip, request.user_agent)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

          RUBY
          end
        end

        def create_migrations
          migration_template 'migrations/create_user_logins.rb', 'db/migrate/create_user_logins.rb'
        end

        private

        def self.next_migration_number(path)
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        end
      end
    end
  end
end
