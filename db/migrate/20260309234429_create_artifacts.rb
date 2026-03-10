class CreateArtifacts < ActiveRecord::Migration[8.1]
  def change
    create_table :artifacts, id: :uuid do |t|
      t.references :session, null: false, foreign_key: true, type: :uuid
      t.string :artifact_type, null: false
      t.string :status, null: false, default: "drafting"
      t.jsonb :content, null: false, default: {}

      t.timestamps
    end
  end
end