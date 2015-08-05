class AddAttachmentArquivoToComprovantes < ActiveRecord::Migration
  def self.up
    change_table :comprovantes do |t|
      t.attachment :arquivo
    end
  end

  def self.down
    remove_attachment :comprovantes, :arquivo
  end
end
