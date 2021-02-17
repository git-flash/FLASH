class CreateAttendanceLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :attendance_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.index [:user_id, :event_id], unique: true
      t.string :passcode, null: false

      t.timestamps
    end
  end
end
