class AddUsuarioIdToAtividades < ActiveRecord::Migration
  def change
    add_column :atividades, :usuario_id, :integer
    add_index :atividades, :usuario_id
  end
end
