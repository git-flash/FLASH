class CreateCommittees < ActiveRecord::Migration[6.1]
  def change
    create_table :committees do |t|
      t.{30} :name

      t.timestamps
    end
  end
end
