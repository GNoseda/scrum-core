class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions, id: :uuid do |t|
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.string :session_type, null: false
      t.string :status, null: false, default: "exploring"

      t.timestamps
    end

  end
end