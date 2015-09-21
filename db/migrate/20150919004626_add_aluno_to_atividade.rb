class AddAlunoToAtividade < ActiveRecord::Migration
  def change
    add_column :atividades, :aluno_id, :string
    add_index :atividades, :aluno_id
  end
end
