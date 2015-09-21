class AddTabelaToDeclaracao < ActiveRecord::Migration
  def change
    add_column :declaracoes, :tabela, :text, array: true
  end
end
