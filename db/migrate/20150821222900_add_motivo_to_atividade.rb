class AddMotivoToAtividade < ActiveRecord::Migration
  def change
    add_column :atividades, :motivo, :string
  end
end
