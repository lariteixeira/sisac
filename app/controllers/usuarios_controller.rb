class UsuariosController < ApplicationController
    def new
        @usuario = Usuario.new
    end

    def create
        @usuario = Usuario.new(usuario_params)

        respond_to do |format|
          if @usuario.save
            current_usuario
            format.html { redirect_to atividades_path, notice: 'Usuario foi criado com sucesso.' }
            format.json { render :show, status: :created, location: @usuario }
          else
            format.html { render :new }
            format.json { render json: @usuario.errors, status: :unprocessable_entity }
          end
        end
    end

    def usuario_params
      params.require(:usuario).permit(:nome, :categoria, :matricula, :password, :email)
    end

end