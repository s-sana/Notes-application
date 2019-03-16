# frozen_string_literal: true

# This Migration to create NoteShares table
class CreateNoteShares < ActiveRecord::Migration[5.2]
  def change
    create_table :note_shares do |t|
      t.references :note, foreign_key: true
      t.string :email
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
