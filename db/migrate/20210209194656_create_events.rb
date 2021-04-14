# frozen_string_literal: true

# Creates events
class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.references :committee, null: false, foreign_key: true
      t.datetime :start_timestamp
      t.datetime :end_timestamp
      t.string :location
      t.integer :point_value
      t.string :passcode

      t.timestamps
    end
  end
end
