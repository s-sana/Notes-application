class CreateRefunds < ActiveRecord::Migration[5.2]
  def change
    create_table :refunds do |t|
      t.references :user, foreign_key: true
      t.string :reason
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
