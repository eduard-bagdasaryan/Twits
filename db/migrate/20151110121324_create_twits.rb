class CreateTwits < ActiveRecord::Migration
  def change
    create_table :twits do |t|
      t.text :message
      t.integer :vote
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
