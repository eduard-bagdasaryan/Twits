class CreateTwits < ActiveRecord::Migration
  def change
    create_table :twits do |t|
      t.text :message, null: false
      t.integer :vote, null: false, default: 0
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
