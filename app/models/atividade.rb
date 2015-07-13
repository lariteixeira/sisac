class Atividade < ActiveRecord::Base
	belongs_to :usuario
	attachment :cv, extension: "pdf"
	validates_presence_of :nome, :professor, :usuario_id
end
