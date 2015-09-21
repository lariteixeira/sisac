class CreateDeclaracoes < ActiveRecord::Migration
  def change
    create_table :declaracoes do |t|
      t.text :texto
      t.integer :tipo
      t.string :chave
      t.string :iduff
      


      t.timestamps
    end
  end
end
