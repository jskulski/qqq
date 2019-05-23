class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :uuid
      t.text :message
      t.datetime :recorded_at

      t.timestamps
    end
    add_index :messages, :uuid
    add_index :messages, :message
    add_index :messages, :recorded_at
  end
end
