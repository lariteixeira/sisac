class LoginController < ApplicationController

    def new
    end

    def create
        usuario = Usuario.find_by_matricula(params[:usuario][:matricula])
        
        if usuario 
            session[:usuario_id] = usuario.id
            redirect_to root_path
        else
            flash.now[:alert] = "Matricula ou senha inválido."
            render action: "new"
        end
    end

    def destroy
        session[:usuario_id] = nil
        redirect_to login_path
    end

end