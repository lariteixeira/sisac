class AddAlunoToDeclaracao < ActiveRecord::Migration
  def change
    add_column :declaracoes, :aluno_id, :integer
    add_index :declaracoes, :aluno_id
  end
end
