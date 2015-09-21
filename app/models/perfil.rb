class Perfil < ActiveRecord::Base

	has_many :usuarios

	ADMINISTRADOR = 1
	ALUNO = 2
	COORDENACAO = 3
	PROFESSOR = 4

end
