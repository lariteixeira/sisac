class DeclaracoesController < ApplicationController


	def validar_declaracao_index
	end

  	def validar_declaracao
    	chave = []
	    (1..4).each do |i|
	      chave << params[:chave]["#{i}"].upcase
	    end
	    @declaracao = Declaracao.where({chave: chave.join("."), iduff: params[:iduff]})

	    if @declaracao
	      @usuario = @declaracao.usuario
	      if @declaracao.tipo == 1
	        texto = @declaracao.texto.split('[]')
	        @informacoes_aluno = texto.shift.split('#')
	        @tabela = texto.map { |b| b.split('#') }
	        render root_path
	      end
	    else
	      flash[:error] = "Declaração não encontrada. Por favor, confira o CPF e a chave."
	      redirect_to validar_declaracao_index_path
	    end
	end

	def declaracao_atividades
		@declaracao = Declaracao.nova_declaracao_aluno(usuario_atual)
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

end
