class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, index: true, unique: true
      t.string :token, null: false, index: true, unique: true

      t.timestamps null: false
    end
  end
end
