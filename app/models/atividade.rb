class Atividade < ActiveRecord::Base
	belongs_to :usuario
	belongs_to :professor
	validates_presence_of :nome, :usuario_id

	has_many :comprovantes, :dependent => :destroy

	STATUS = ["EM_PROCESSAMENTO", "ACEITA", "REJEITADA", "CONFIRMADA"]
	
end
