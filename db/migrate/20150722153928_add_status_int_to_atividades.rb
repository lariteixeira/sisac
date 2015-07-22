class AddStatusIntToAtividades < ActiveRecord::Migration
  def change
  	 add_column :atividades, :status_int, :integer
  end
end
