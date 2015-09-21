class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.boolean :avaliador

      t.timestamps null: false
    end
  end
end
