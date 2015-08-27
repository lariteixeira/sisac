class AtividadesController < ApplicationController
  before_filter :authorize_usuario
  before_action :set_atividade, only: [:show, :edit, :update, :destroy, :aceita, :confirma, :rejeita]

  # GET /atividades
  # GET /atividades.json
  def index
    case usuario_atual.categoria
      when "Aluno"
        @atividades = Atividade.where({usuario_id: usuario_atual.id})
      # when "Professor"
      #   @atividades = Atividade.where({professor: [usuario_atual.nome , nil]})
      when "admin" || "Coordenacao" || "Secretaria"
        @atividades = Atividade.all
      else
         @atividades = Atividade.all
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = AtividadePdf.new(@atividades)
        send_data pdf.render, filename: "atividade",
                              type: "application/pdf",
                              disposition: "inline"

      end
    end
  end

  # GET /atividades/1
  # GET /atividades/1.json
  def show
  end

  # GET /atividades/new
  def new
    @atividade = usuario_atual.atividades.build
  end

  # GET /atividades/1/edit
  def edit
  end

  # POST /atividades
  # POST /atividades.json
  def create
    @atividade = usuario_atual.atividades.build(atividade_params)
    @atividade.aluno = usuario_atual.nome

    #set status Em processamento para nova atividade
    set_status(@atividade)
    
    UsuarioMailer.novo_pedido_email(usuario_atual).deliver_now

    respond_to do |format|
      if @atividade.save

        #salva os comprovantes
        if params[:arquivos]
          params[:arquivos].each_with_index { |arquivo, index|
            if @atividade.comprovantes.create(arquivo: arquivo, arquivo_file_name: Comprovante.nome_arquivo(usuario_atual.nome, index))
              format.html { render :show, notice: 'Comprovante foi salvo.' }
              format.json { render :show, status: :ok, location: @atividade }
            else
              format.html { render :edit, alert: "Nao foi possivel salvar o comprovante" }
            end
          }
        end

        format.html { redirect_to @atividade, notice: 'Atividade foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @atividade }
      else
        format.html { render :new }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /atividades/1
  # PATCH/PUT /atividades/1.json
  def update
    respond_to do |format|

      if @atividade.update(atividade_params)

        if params[:arquivos]
          params[:arquivos].each_with_index { |arquivo, index|
            # if params[:comprovante_ids]
              # comp_index = params[:comprovante_ids].first
              # outro_index = params[:comprovante_ids].last

            titulo = Comprovante.nome_arquivo(usuario_atual.nome, index)
            

            if @atividade.comprovantes.create(arquivo: arquivo, arquivo_file_name: titulo)
              format.html { redirect_to @atividade, notice: 'Comprovante foi salvo.' }
              format.json { render :show, status: :ok, location: @atividade }
            else
              format.html { render :edit, alert: "Nao foi possivel salvar o comprovante" }
            end

          }
        end

        format.html { redirect_to @atividade, notice: 'Atividade foi atualizada.' }
        format.json { render :show, status: :ok, location: @atividade }
      else
        format.html { render :edit }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  def aceita
      if @atividade.update_attributes({:status => "Aceita", :professor => usuario_atual.id.to_s})
       # && usuario_atual.professor.atividades << @atividade )

        redirect_to @atividade, notice: 'Atividade foi atualizada.'
      else
        render json: @atividade.errors, status: :unprocessable_entity
      end
  end

  # def rejeita
  #   if @atividade.update_attributes({:status => "Rejeitada", :motivo => params[:motivo]})
  #     #enviar email
  #     redirect_to atividades_path, notice: 'Atividade foi atualizada.'
  #   else
  #     render json: @atividade.errors, status: :unprocessable_entity
  #   end
  # end

  # def rejeita_index
  #   redirect_to , notice: 'Atividade foi atualizada.'
  # end

  def confirma
      if @atividade.update_attributes({:status=> "Confirmada"})

        redirect_to @atividade, notice: 'Atividade foi atualizada.'
      else
        render json: @atividade.errors, status: :unprocessable_entity
      end
  end

  # DELETE /atividades/1
  # DELETE /atividades/1.json
  def destroy
    @atividade.destroy
    respond_to do |format|
      format.html { redirect_to atividades_url, notice: 'Atividade foi deletada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_atividade
      @atividade = Atividade.where(id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def atividade_params
      params.require(:atividade).permit(:nome, :status, :professor, :motivo)
    end

    def set_status(atividade)
      atividade.status = "Em Processamento"
    end

end
