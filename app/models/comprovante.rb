class Comprovante < ActiveRecord::Base
  belongs_to :atividade
  
  has_attached_file :arquivo
  validates_attachment_size :arquivo, :less_than => 2.megabyte, :if => :arquivo, :message => "deve ser menor que 2 MB", :on => :create
  validates_attachment_content_type :arquivo, :content_type => 'application/pdf', :message => :invalid, :if => :arquivo
end
