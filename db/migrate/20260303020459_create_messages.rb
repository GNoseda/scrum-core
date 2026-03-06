class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.uuid :session_id, null: false
      t.integer :role, null: false
      t.text :content, null: false
      t.jsonb :references, default: [], null: false

      t.timestamps
    end

    add_index :messages, :session_id
  end
end