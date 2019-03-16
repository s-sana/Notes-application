# frozen_string_literal: true

# Adding username column in the Users table
class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, unique: true
  end
end
