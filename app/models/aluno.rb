class Aluno < ActiveRecord::Base
	belongs_to :usuario
	has_many :atividades
end
