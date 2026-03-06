class CreateDraftArtifacts < ActiveRecord::Migration[8.1]
  def change
    create_table :draft_artifacts, id: :uuid do |t|
      t.references :session, null: false, foreign_key: true, type: :uuid
      t.string :artifact_type, null: false
      t.integer :version, null: false
      t.jsonb :structured_content, null: false

      t.timestamps
    end

    add_index :draft_artifacts, [:session_id, :version], unique: true
  end
end