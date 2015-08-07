class AtividadesController < ApplicationController
  before_filter :authorize_usuario
  before_action :set_atividade, only: [:show, :edit, :update, :destroy, :aceita]

  # GET /atividades
  # GET /atividades.json
  def index
    @atividades = Atividade.all
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
    @atividade = current_usuario.atividades.build
  end

  # GET /atividades/1/edit
  def edit
  end

  # POST /atividades
  # POST /atividades.json
  def create
    @atividade = current_usuario.atividades.build(atividade_params)
    #set status Em processamento para nova atividade
    set_status(@atividade)
    
    UsuarioMailer.novo_pedido_email(current_usuario).deliver_now

    respond_to do |format|
      if @atividade.save

        #salva os comprovantes
        if params[:arquivos]
          params[:arquivos].each { |arquivo|
            if @atividade.comprovantes.create(arquivo: arquivo)
              format.html { render :show, notice: 'Comprovante foi salvo.' }
              format.json { render :show, status: :ok, location: @atividade }
            else
              format.html { render :edit, alert: "Nao foi possivel salvar o comprovante" }
            end
          }
        end

        #true se tiver comprovante
        comprovante_status(@atividade)

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
          params[:arquivos].each { |arquivo|
            if @atividade.comprovantes.create(arquivo: arquivo)
              format.html { redirect_to @atividade, notice: 'Comprovante foi salvo.' }
              format.json { render :show, status: :ok, location: @atividade }
            else
              format.html { render :edit, alert: "Nao foi possivel salvar o comprovante" }
            end

          }
        end

        comprovante_status(@atividade)
        format.html { redirect_to @atividade, notice: 'Atividade foi atualizada.' }
        format.json { render :show, status: :ok, location: @atividade }
      else
        format.html { render :edit }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  def aceita
      if @atividade.update_attributes(professor: current_usuario.nome, status: "Aceita")
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
      @atividade = Atividade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def atividade_params
      params.require(:atividade).permit(:nome, :status, :documento)
    end

    def comprovante_status(id)
      @atividade = Atividade.find(id)
      if @atividade

        if @atividade.comprovantes.empty?
          @atividade.update_attribute(:documento, false)
        else
          @atividade.update_attribute(:documento, true)
        end

      end
    end

    def set_status(atividade)
      atividade.status = "Em Processamento"
    end

private

  def authorize_usuario
    unless current_usuario
      redirect_to login_path, alert: "Faça o login para continuar."
    end
  end

end
