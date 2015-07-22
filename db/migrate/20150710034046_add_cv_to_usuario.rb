class AddCvToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :string
  end
end
