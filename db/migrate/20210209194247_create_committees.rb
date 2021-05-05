# frozen_string_literal: true

# Creates committees
class CreateCommittees < ActiveRecord::Migration[6.1]
  def change
    create_table :committees do |t|
      t.string :name

      t.timestamps
    end
  end
end
