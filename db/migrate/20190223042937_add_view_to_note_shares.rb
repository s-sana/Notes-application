# frozen_string_literal: true

# This migration is add  view column in Noteshares
class AddViewToNoteShares < ActiveRecord::Migration[5.2]
  def change
    add_column :note_shares, :view, :boolean, default: false
  end
end
