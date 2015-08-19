class CreatePerfisUsuarios < ActiveRecord::Migration
  def change
    create_table :perfis_usuarios do |t|
      t.integer :usuario_id
      t.integer :perfil_id
    end
  end
end
