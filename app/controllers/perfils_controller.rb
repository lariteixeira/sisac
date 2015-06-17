class PerfilsController < ApplicationController
    def new
        @perfil = Perfil.new
    end

    def create
        @perfil = Perfil.new(perfil_params)

        respond_to do |format|
          if @perfil.save
            format.html { redirect_to atividades_path, notice: 'Perfil foi criado com sucesso.' }
            format.json { render :show, status: :created, location: @perfil }
          else
            format.html { render :new }
            format.json { render json: @perfil.errors, status: :unprocessable_entity }
          end
        end
    end

    def perfil_params
      params.require(:perfil).permit(:nome, :categoria, :matricula, :password)
    end

end