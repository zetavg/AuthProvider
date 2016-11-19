class CreateAuthProviderOAuthSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :auth_provider_oauth_sessions do |t|
      t.integer :resource_owner_id, null: false
      t.integer :resource_owner_type, null: false

      t.string :device_name
      t.string :device_type
      t.text :device_identifier

      t.datetime :created_at, null: false
      t.datetime :revoked_at
    end

    add_index :auth_provider_oauth_sessions, :resource_owner_id
    add_index :auth_provider_oauth_sessions, :resource_owner_type
    add_index :auth_provider_oauth_sessions, :device_type
    add_index :auth_provider_oauth_sessions, :revoked_at
  end
end
