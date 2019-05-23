class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :uuid
      t.text :message
      t.datetime :recorded_on

      t.timestamps
    end
    add_index :events, :uuid
    add_index :events, :message
    add_index :events, :recorded_on
  end
end
