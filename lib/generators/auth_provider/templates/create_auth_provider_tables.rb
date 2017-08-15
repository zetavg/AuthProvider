class CreateAuthProviderTables < ActiveRecord::Migration[4.2]
  def change
    create_table :oauth_sessions do |t|
      t.integer :resource_owner_id, null: false
      t.string :resource_owner_type, null: false

      t.string :device_name
      t.string :device_type
      t.text :device_identifier

      t.datetime :created_at, null: false
      t.datetime :revoked_at
    end

    add_index :oauth_sessions, :resource_owner_id
    add_index :oauth_sessions, :resource_owner_type
    add_index :oauth_sessions, :device_type
    add_index :oauth_sessions, :revoked_at

    create_table :oauth_access_tokens do |t|
      t.integer :oauth_session_id, null: false
      t.text :token, null: false
      t.text :refresh_token
      t.integer :expires_in, null: false

      t.datetime :created_at, null: false
      t.datetime :revoked_at
    end

    add_index :oauth_access_tokens, :oauth_session_id
    add_index :oauth_access_tokens, :token, unique: true
    add_index :oauth_access_tokens, :refresh_token, unique: true
    add_index :oauth_access_tokens, :revoked_at

    add_foreign_key :oauth_access_tokens, :auth_provider_oauth_sessions
  end
end
