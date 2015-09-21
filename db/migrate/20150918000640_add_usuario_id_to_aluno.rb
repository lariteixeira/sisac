class AddUsuarioIdToAluno < ActiveRecord::Migration
  def change
    add_column :alunos, :usuario_id, :integer
    add_index :alunos, :usuario_id
  end
end
