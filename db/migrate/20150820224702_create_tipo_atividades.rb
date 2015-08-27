class CreateTipoAtividades < ActiveRecord::Migration
  def change
    create_table :tipo_atividades do |t|
      t.string :nome
      t.string :descricao

      t.timestamps null: false
    end
  end
end
