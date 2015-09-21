class AddDescricaoToAtividade < ActiveRecord::Migration
  def change
    add_column :atividades, :descricao, :text
  end
end
