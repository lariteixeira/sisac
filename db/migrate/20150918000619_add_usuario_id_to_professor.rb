class AddUsuarioIdToProfessor < ActiveRecord::Migration
  def change
    add_column :professores, :usuario_id, :integer
    add_index :professores, :usuario_id
  end
end
