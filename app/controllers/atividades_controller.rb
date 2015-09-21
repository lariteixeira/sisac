class AtividadesController < ApplicationController
  before_filter :authorize_usuario
  before_action :set_atividade, only: [:show, :edit, :update, :destroy, :avalia, :valida, :confirma, :cancela, :remove_arquivo]

  # GET /atividades
  # GET /atividades.json
  def index
    case usuario_atual.categoria
      when "Aluno"
        @atividades = Atividade.where({usuario_id: usuario_atual.id}).group("status", "id")
      when "Professor"
         @atividades = Atividade.where({professor: [usuario_atual.nome , nil]})
      when "Administrador" || "Coordenacao" || "Secretaria"
        @atividades = Atividade.all.group("status", "id")
      else
         @atividades = Atividade.all.group("status", "id")
    end
    respond_to do |format|
      format.html
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
    @atividade.status = "Registrada" #TODO check set default options

    respond_to do |format|
      if @atividade.save
        # UsuarioMailer.novo_pedido_email(usuario_atual, "registrada").deliver_now
        format.html { redirect_to @atividade, notice: 'Atividade foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @atividade }
      else
        format.html { render :new, alert: 'Atividade nao pode ser criada' }
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

            @comprovante = Comprovante.novo_comprovante(arquivo, index, usuario_atual.nome)
            @comprovante.atividade = @atividade
            if !@comprovante.save
              flash[:alert] = "Nao foi possivel salvar o comprovante"
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

  def avalia
    ac_status = "Processando"
    if @atividade.update_attributes(status: ac_status, professor: usuario_atual.id.to_s)
        UsuarioMailer.novo_pedido_email(usuario_atual, ac_status ).deliver_now
        redirect_to @atividade, notice: 'Atividade foi atualizada.'
      else
        render json: @atividade.errors, status: :unprocessable_entity
      end
  end

  def valida
   ac_status = "Validada"
    if @atividade.update_attributes(status: ac_status)
      UsuarioMailer.novo_pedido_email(usuario_atual, ac_status).deliver_now
      redirect_to @atividade, notice: 'Atividade foi atualizada.'
    else
      render json: @atividade.errors, status: :unprocessable_entity
    end
  end

  def confirma
    ac_status = "Confirmada"
      if @atividade.update_attributes(status: ac_status)
        UsuarioMailer.novo_pedido_email(usuario_atual, ac_status).deliver_now
        redirect_to @atividade, notice: 'Atividade foi atualizada.'
      else
        render json: @atividade.errors, status: :unprocessable_entity
      end
  end

  def cancela
    ac_status = "Cancelada"
    if @atividade.update_attributes(status: ac_status)
      UsuarioMailer.novo_pedido_email(usuario_atual, ac_status).deliver_now
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

  def remove_arquivo

     c = @atividade.comprovantes[params[:comp_index].to_i]
     c.destroy
     @atividade.save
     respond_to do |format|
       format.html { redirect_to @atividade, notice: 'Arquivo removido.' }
       format.json { render :show, status: :ok, location: @atividade }
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
end
