class CreatePerfis < ActiveRecord::Migration
  def change
    create_table :perfis do |t|
      t.string :nome

      t.timestamps null: false
    end
  end
end
