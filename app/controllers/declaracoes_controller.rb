class DeclaracoesController < ApplicationController


	def validar_declaracao_index
	end

  	def validar_declaracao
    	chave = []
	    (1..4).each do |i|
	      chave << params[:chave]["#{i}"].upcase
	    end
	   d = Declaracao.where("chave = ?", chave.join(".")).first
	   if d
	   	decl = d.to_json
	   		declaracao = JSON.parse(decl)
	    if declaracao.any?
	      @usuario = Usuario.find(declaracao['usuario_id'])
	      tabela = declaracao['tabela']
	      respond_to do |format|
		  format.html { redirect_to validar_declaracao_index_path, notice: 'Declaracao válida.'}
	    end
	        
	      end
	    else
	    	respond_to do |format|
				format.html { redirect_to validar_declaracao_index_path, alert: 'Declaração não encontrada. Por favor, confira o CPF e a chave.'}
	        
	    end
	   end
	end

	def declaracao_atividades
		@declaracao = Declaracao.nova_declaracao_aluno(usuario_atual)
    	@declaracao.save
    	@hora = Time.now.localtime
    	respond_to do |format|
	      format.pdf do
          pdf = DeclaracaoPdf.new(@declaracao, view_context, @hora)
          # @declaracao.arquivo = pdf
          # @declaracao.save
          send_data pdf.render, type: "application/pdf",
                              disposition: "inline"
          end
    	end
	end

end
