class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.references :committee, null: false, foreign_key: true
      t.integer :type
      t.integer :uin

      t.timestamps
    end
  end
end
