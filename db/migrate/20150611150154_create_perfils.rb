class CreatePerfils < ActiveRecord::Migration
  def change
    create_table :perfils do |t|
      t.string :nome
      t.string :categoria
      t.string :matricula

      t.timestamps null: false
    end
  end
end
