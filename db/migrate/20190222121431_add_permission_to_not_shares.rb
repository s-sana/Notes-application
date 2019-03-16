# frozen_string_literal: true

class AddPermissionToNotShares < ActiveRecord::Migration[5.2]
  def change
    add_column :note_shares, :edit, :boolean, default: false
  end
end
