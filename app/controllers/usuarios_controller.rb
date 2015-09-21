class UsuariosController < ApplicationController

    before_action :set_usuario, only: [:update]
    after_action :confere_perfil, only: [:create, :update]

    def new
        @usuario = Usuario.new
    end
    
    def create
        @usuario = Usuario.new(usuario_params)
        
        respond_to do |format|
          if @usuario.save
            


            usuario_atual
            session[:usuario_id] = @usuario.id

            format.html { redirect_to root_path, notice: 'Usuario foi criado com sucesso.' }
            format.json { render :show, status: :created, location: @usuario }
          else
            format.html { render :new }
            format.json { render json: @usuario.errors, status: :unprocessable_entity }
          end
        end
    end

    def edit
        @usuario = usuario_atual
    end
 
    def update
        respond_to do |format|

          if @usuario.update(usuario_params)
            format.html { redirect_to root_path, notice: 'Usuario foi atualizada.' }
            format.json { render :show, status: :ok, location: @usuario }
          else
            format.html { render :edit }
            format.json { render json: @usuario.errors, status: :unprocessable_entity }
          end
        end
    end

    private

    # Confere o perfil do usuario cadastrado
    def confere_perfil

        if @usuario.perfis.empty? || @usuario.perfil_ids.include? Perfil::ALUNO
            # Se o usuario nao tiver perfil ou o perfil for de aluno, salva como aluno
            @usuario.cria_aluno
        elsif @usuario.perfil_ids.include? Perfil::PROFESSOR
            # Se o usuario for um professor, salva como professor
            @usuario.cria_professor(params[:avaliador])
        end

    end
        
    end
    
    def usuario_params
      params.require(:usuario).permit(:nome, :perfil_ids, :iduff, :email)
    end

    private
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

end