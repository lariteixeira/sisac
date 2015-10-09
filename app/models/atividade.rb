class Atividade < ActiveRecord::Base
	
	belongs_to :aluno
	belongs_to :professor
	validates_presence_of :nome, :aluno_id
	has_many :comprovantes, :dependent => :destroy
	has_many :declaracoes

	# validates_attachment_size :arquivos[], :less_than => 2.megabyte, :if => :arquivo, :message => "deve ser menor que 2 MB", :on => :create
 #   	validates_attachment_content_type :arquivo, :content_type => 'application/pdf', :message => :invalid, :if => :arquivo


	STATUS = ["TODOS", "REGISTRADA", "PROCESSANDO", "VALIDADA", "REJEITADA", "CONFIRMADA", "CANCELADA"]
	
	REGISTRADA = 1
	VALIDADA = 2
	REJEITADA = 3
	CONFIRMADA = 4
	CANCELADA = 5
	
end
