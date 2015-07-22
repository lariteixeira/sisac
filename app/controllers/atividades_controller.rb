class AtividadesController < ApplicationController
  before_filter :authorize_usuario, only: [:new, :create]
  before_action :set_atividade, only: [:show, :edit, :update, :destroy]

  # GET /atividades
  # GET /atividades.json
  def index
    @atividades = Atividade.all
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
    comprovante(@atividade)
    set_status(@atividade)
    UsuarioMailer.welcome_email(current_usuario).deliver_now
    respond_to do |format|
      if @atividade.save
        format.html { redirect_to @atividade, notice: 'Atividade foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @atividade }
      else
        format.html { render :new }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  def aceita
    @atividade.professor = current_usuario.nome
    @atividade.status = "Aceita"
    update
  end



  # PATCH/PUT /atividades/1
  # PATCH/PUT /atividades/1.json
  def update
    respond_to do |format|
      if @atividade.update(atividade_params)
        comprovante(@atividade)
        format.html { redirect_to @atividade, notice: 'Atividade foi atualizada.' }
        format.json { render :show, status: :ok, location: @atividade }
      else
        format.html { render :edit }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
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
   

    def comprovante(atividade)
      if atividade.cv
        atividade.documento = true
      else
        atividade.documento = false
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

   def atividade_params
      params.require(:atividade).permit(:nome, :status, :documento, :cv, :status_int)
    end

end
