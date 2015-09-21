class Declaracao < ActiveRecord::Base
	belongs_to :usuario

	def self.nova_declaracao_aluno(usuario)
		declaracao = Declaracao.new
		declaracao.usuario = usuario
    	declaracao.tabela = declaracao.gera_tabela_aluno
    	declaracao.iduff = declaracao.usuario.iduff
    	declaracao.chave = declaracao.gera_chave
    	declaracao
	end

	def gera_tabela
		
	end

	def gera_tabela_aluno
		tabela = [["Nome", "Professor", "Criado em", "Última Atualização", "Status"]]
		tabela += usuario.atividades.collect{ |a| [a.nome, a.professor.usuario.nome, a.created_at.localtime.strftime("%d-%m-%y"), a.updated_at.localtime.strftime("%d-%m-%y"), a.status]}
	end

	def gera_tabela_professor
		tabela = [["Nome", "Professor", "Criado em", "Última Atualização", "Status"]]
		tabela += usuario.atividades.collect{ |a| [a.nome, a.aluno.usuario.nome, a.created_at.localtime.strftime("%d-%m-%y"), a.updated_at.localtime.strftime("%d-%m-%y"), a.status]}
	end

	def gera_texto_coordenacao
	end

	def gera_chave
    	chave_gerada = Digest::SHA1.hexdigest(self.iduff.to_s + Time.now.to_s)[0..15].upcase
    	chave_gerada[0..3] + "." + chave_gerada[4..7] + "." + chave_gerada[8..11] + "." + chave_gerada[12..15]
  	end

end
