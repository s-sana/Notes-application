# frozen_string_literal: true

# This migration is to add column (autosave) to Users table
class AddAutoSaveToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :autosave, :boolean, default: false
  end
end
