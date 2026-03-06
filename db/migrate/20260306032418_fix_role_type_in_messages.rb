class FixRoleTypeInMessages < ActiveRecord::Migration[8.1]
  def change
    change_column :messages, :role, :integer, using: 'role::integer'
  end
end