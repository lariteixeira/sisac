class AddArquivoToDeclaracoes < ActiveRecord::Migration
    def self.up
    change_table :declaracoes do |t|
      t.attachment :arquivo
    end
  end

  def self.down
    remove_attachment :declaracoes, :arquivo
  end
end
