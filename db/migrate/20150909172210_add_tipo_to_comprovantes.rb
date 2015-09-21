class AddTipoToComprovantes < ActiveRecord::Migration
  def change
    add_column :comprovantes, :tipo, :integer
  end
end
