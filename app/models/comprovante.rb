class Comprovante < ActiveRecord::Base
  belongs_to :atividade
  
  has_attached_file :arquivo
  validates_attachment_size :arquivo, :less_than => 2.megabyte, :if => :arquivo, :message => "deve ser menor que 2 MB", :on => :create
  validates_attachment_content_type :arquivo, :content_type => 'application/pdf', :message => :invalid, :if => :arquivo

  COMPROVANTE = 0
  OUTRO = 1
  
  def self.nome_arquivo(nome, index)
  	if index == COMPROVANTE
  		tipo_doc = "comprovante"
  	elsif index == OUTRO
  		tipo_doc = "outro"
  	end
  	data_criacao = DateTime.now.to_s
  	titulo = data_criacao + "_" + nome + "_" + tipo_doc + ".pdf"
  end

end
