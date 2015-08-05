class Atividade < ActiveRecord::Base
	belongs_to :usuario
	validates_presence_of :nome, :usuario_id

	has_many :comprovantes, :dependent => :destroy

end
