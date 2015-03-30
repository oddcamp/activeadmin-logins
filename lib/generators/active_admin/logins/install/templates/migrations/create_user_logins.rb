class CreateUserLogins < ActiveRecord::Migration
  def self.up
    create_table "user_logins" do |t|
      t.integer  "user_id"
      t.string   "ip",         null: false
      t.string   "user_agent"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "country"
      t.string   "city"
    end

    add_index "user_logins", ["user_id"]
  end

  def self.down
    drop_table :user_logins
  end
end
