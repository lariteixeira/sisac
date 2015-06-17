class Atividade < ActiveRecord::Base
	belongs_to :usuario
	validates_presence_of :nome, :professor, :usuario_id
end
