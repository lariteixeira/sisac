class CreateAlunos < ActiveRecord::Migration
  def change
    create_table :alunos do |t|

      t.timestamps null: false
    end
  end
end
