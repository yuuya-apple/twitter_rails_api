# frozen_string_literal: true

class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_users_table
    add_users_indexes
  end

  def down
    drop_table :users
  end

  private

  def create_users_table
    create_table(:users) do |table|
      add_required_columns(table)
      add_database_authenticatable_columns(table)
      add_recoverable_columns(table)
      add_rememberable_columns(table)
      add_confirmable_columns(table)
      add_user_info_columns(table)
      add_tokens_column(table)

      table.timestamps
    end
  end

  def add_required_columns(table)
    table.string :provider, null: false, default: 'email'
    table.string :uid, null: false, default: ''
  end

  def add_database_authenticatable_columns(table)
    table.string :encrypted_password, null: false, default: ''
  end

  def add_recoverable_columns(table)
    table.string   :reset_password_token
    table.datetime :reset_password_sent_at
    table.boolean  :allow_password_change, default: false, null: false
  end

  def add_rememberable_columns(table)
    table.datetime :remember_created_at
  end

  def add_confirmable_columns(table)
    table.string   :confirmation_token
    table.datetime :confirmed_at
    table.datetime :confirmation_sent_at
    table.string   :unconfirmed_email # Only if using reconfirmable
  end

  def add_user_info_columns(table)
    table.string :name
    table.string :nickname
    table.string :image
    table.string :email
  end

  def add_tokens_column(table)
    table.json :tokens
  end

  def add_users_indexes
    add_index :users, :email, unique: true
    add_index :users, %i[uid provider], unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token, unique: true
    # add_index :users, :unlock_token, unique: true
  end
end
