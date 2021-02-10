class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :committee, null: true, foreign_key: true
      t.integer :user_type, null: false, default: 0
      t.integer :uin, null: false

      t.timestamps
    end
  end
end
