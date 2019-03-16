# frozen_string_literal: true

# Adding the status column in notes table
class AddStatusToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :status, :boolean, default: true
  end
end
