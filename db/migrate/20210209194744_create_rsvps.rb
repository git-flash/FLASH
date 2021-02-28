class CreateRsvps < ActiveRecord::Migration[6.1]
  def change
    create_table :rsvps do |t|
      t.references :user, :null => false, :foreign_key => true
      t.references :event, :null => false, :foreign_key => true
      t.integer :rsvp_option

      t.timestamps
    end
  end
end
