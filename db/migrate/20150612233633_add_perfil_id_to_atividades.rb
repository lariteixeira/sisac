class AddPerfilIdToAtividades < ActiveRecord::Migration
  def change
    add_column :atividades, :perfil_id, :integer
    add_index :atividades, :perfil_id
  end
end
