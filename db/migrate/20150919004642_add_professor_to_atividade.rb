class AddProfessorToAtividade < ActiveRecord::Migration
  def change
    add_column :atividades, :professor_id, :string
    add_index :atividades, :professor_id
  end
end
