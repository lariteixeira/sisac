class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :categoria
      t.string :matricula

      t.timestamps null: false
    end
  end
end
