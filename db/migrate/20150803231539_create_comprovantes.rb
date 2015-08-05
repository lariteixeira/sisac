class CreateComprovantes < ActiveRecord::Migration
  def change
    create_table :comprovantes do |t|
      t.belongs_to :atividade, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
