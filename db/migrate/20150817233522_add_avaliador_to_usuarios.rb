class AddAvaliadorToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :avaliador, :boolean
  end
end
