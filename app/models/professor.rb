class Professor < ActiveRecord::Base
	has_many :atividades
	belongs_to :usuario
	
	validates_presence_of :usuario

	def avaliador
		self.avaliador = true
		self.save
	end
end
