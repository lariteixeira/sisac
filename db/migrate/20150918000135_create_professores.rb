class CreateProfessores < ActiveRecord::Migration
  def change
    create_table :professores do |t|
      t.boolean :avaliador

      t.timestamps null: false
    end
    add_index :professores, :usuario
  end
end
