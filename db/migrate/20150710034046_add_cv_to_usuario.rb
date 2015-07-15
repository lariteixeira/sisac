class AddCvToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :cv_id, :string
  end
end
