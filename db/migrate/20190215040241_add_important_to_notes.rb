# frozen_string_literal: true

# This migration is to add column (important) to Notes table
class AddImportantToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :important, :boolean, default: false
  end
end
