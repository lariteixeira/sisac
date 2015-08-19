class CreateAtividades < ActiveRecord::Migration
  def change
    create_table :atividades do |t|
      t.string :nome
      t.string :status
      t.string :professor
      t.string :aluno

      t.timestamps null: false
    end
  end
end
