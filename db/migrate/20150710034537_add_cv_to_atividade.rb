class AddCvToAtividade < ActiveRecord::Migration
  def change
    add_column :atividades, :cv_id, :string
  end
end
