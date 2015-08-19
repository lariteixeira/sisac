class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :categoria
      t.string :iduff
      t.string :email

      t.timestamps null: false
    end
  end
end
