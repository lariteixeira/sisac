class AddPasswordDigestToPerfils < ActiveRecord::Migration
  def change
    add_column :perfils, :password_digest, :string
  end
end
