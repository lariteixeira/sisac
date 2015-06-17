class Atividade < ActiveRecord::Base
	belongs_to :perfil
	validates_presence_of :nome, :professor, :perfil_id
end
