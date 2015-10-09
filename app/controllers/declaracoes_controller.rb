class DeclaracoesController < ApplicationController

	def show
		redirect_to 'declaracoes/validar_declaracao'
	end

	def validar_declaracao_index
	end

  	def validar_declaracao
  		chave = []
  		(1..4).each do |i|
  			chave << params[:chave]["#{i}"].upcase
  		end
  		@declaracao = Declaracao.where(chave: chave.join(".")).first
  		if @declaracao
			render '/declaracoes/validar_declaracao'
  		else
  			redirect_to validar_declaracao_index_path, alert: 'Declaração não encontrada. Por favor, confira o CPF e a chave.'
  		end
  	end

	def declaracao_atividades
		@declaracao = Declaracao.nova_declaracao(usuario_atual)
		@declaracao.save
		@hora = Time.now.localtime
		respond_to do |format|
			format.pdf do
				pdf = DeclaracaoPdf.new(@declaracao, view_context, @hora)
				send_data pdf.render, type: "application/pdf",
				disposition: "inline"
			end
		end
	end

	def relatorio_atividades
		@declaracao = Declaracao.novo_relatorio(usuario_atual)
		@declaracao.save
		@hora = Time.now.localtime
		respond_to do |format|
			format.pdf do
	          pdf = RelatorioPdf.new(@declaracao, view_context, @hora)
	          send_data pdf.render, type: "application/pdf",
                              disposition: "inline"
            end
		end
	end

end
