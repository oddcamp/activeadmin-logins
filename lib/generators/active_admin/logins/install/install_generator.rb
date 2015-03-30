require 'rails/generators'
require 'rails/generators/migration'

module ActiveAdmin
  module Logins
    module Generators
      class InstallGenerator < Rails::Generators::Base
        include Rails::Generators::Migration

        desc "Generates the necessary migrations and routes"

        source_root File.expand_path("../templates", __FILE__)

        # def setup_routes
        #   route "\n  namespace :admin do\n    resources :logins\n  end"
        # end

        def inject_into_user_model
          inject_into_file 'app/models/user.rb', after: "class User < ActiveRecord::Base\n" do <<-'RUBY'

  has_many :user_logins, dependent: :destroy

  def update_tracked_fields(request)
    super
    UserLoginWorker.perform_async(self.id, request.remote_ip, request.user_agent)
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
