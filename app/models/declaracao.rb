class Declaracao < ActiveRecord::Base
	belongs_to :usuario
	has_many :atividades



	def self.nova_declaracao(usuario)
		declaracao = Declaracao.new
		declaracao.usuario = usuario
		declaracao.tabela = declaracao.gera_tabela_confirmadas(usuario)
    	declaracao.iduff = declaracao.usuario.iduff
    	declaracao.chave = declaracao.gera_chave
    	declaracao
	end

	def self.novo_relatorio(usuario)
		declaracao = Declaracao.new
		declaracao.usuario = usuario
    	declaracao.tabela = declaracao.gera_tabela(usuario, declaracao)
    	declaracao.iduff = declaracao.usuario.iduff
    	declaracao.chave = declaracao.gera_chave
    	declaracao
	end

	def gera_tabela_confirmadas(usuario)
		tabela = [["Nome", "Descrição", "Professor", "Criado em", "Última Atualização", "Status"]]
		tabela += usuario.atividades.collect{ |a| [a.nome, a.descricao, a.professor.usuario.nome, a.created_at.localtime.strftime("%d-%m-%y"), a.updated_at.localtime.strftime("%d-%m-%y"), a.status]}
		tabela
	end

	def gera_tabela(usuario, declaracao)
		if usuario.categoria == "Aluno"
			tabela = declaracao.gera_tabela_aluno(usuario)
		elsif usuario.categoria == "Professor"
			tabela = declaracao.gera_tabela_professor(usuario)
		else
			tabela = declaracao.gera_tabela_coordenacao(usuario)
		end
		tabela
	end

	def gera_tabela_aluno(usuario)
		tabela = [["Nome", "Professor", "Criado em", "Última Atualização", "Status"]]
		tabela += usuario.atividades.collect{ |a| [a.nome, a.professor.usuario.nome, a.created_at.localtime.strftime("%d-%m-%y"), a.updated_at.localtime.strftime("%d-%m-%y"), a.status]}
		tabela
	end

	def gera_tabela_professor(usuario)
		tabela = [["Nome", "Aluno", "Criado em", "Última Atualização", "Status"]]
		tabela += @usuario.atividades.collect{ |a| [a.nome, a.aluno.usuario.nome, a.created_at.localtime.strftime("%d-%m-%y"), a.updated_at.localtime.strftime("%d-%m-%y"), a.status]}
		tabela
	end

	def gera_tabela_coordenacao(usuario)
		tabela = [["Nome", "Aluno", "Professor", "Criado em", "Atualização", "Status"]]
		tabela += Atividade.all.collect{ |a| [a.nome, a.aluno.usuario.nome, a.professor.usuario.nome, a.created_at.localtime.strftime("%d-%m-%y"), a.updated_at.localtime.strftime("%d-%m-%y"), a.status]}
	end

	def gera_chave
    	chave_gerada = Digest::SHA1.hexdigest(self.iduff.to_s + Time.now.to_s)[0..15].upcase
    	chave_gerada[0..3] + "." + chave_gerada[4..7] + "." + chave_gerada[8..11] + "." + chave_gerada[12..15]
  	end

  	def self.converte_json(declaracao_json)
  		declaracao = Declaracao.new
  		declaracao.id = declaracao_json['id']
  		declaracao.tabela = declaracao_json['tabela']
    	declaracao.iduff = declaracao_json['iduff']
    	declaracao.chave = declaracao_json['chave']
    	declaracao
  	end
end
