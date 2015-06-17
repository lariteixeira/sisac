class LoginController < ApplicationController

    def new
    end

    def create
        perfil = Perfil.find_by_matricula(params[:perfil][:matricula])
        
        if perfil 
            # && Perfil.validates_confirmation_of(params[:perfil][:password])
            session[:perfil_id] = perfil.id
            redirect_to root_path
        else
            flash.now[:alert] = "Matricula ou senha inválido."
            render action: "new"
        end
    end

    def destroy
        session[:perfil_id] = nil
        redirect_to login_path
    end

end