class AddUsuarioToDeclaracoes < ActiveRecord::Migration
  def change
  	add_column :declaracoes, :usuario_id, :integer
    add_index :declaracoes, :usuario_id
  end
end