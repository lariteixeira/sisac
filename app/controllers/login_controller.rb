class LoginController < ApplicationController

    def new

    end

    def create
        #TODO: Colocar IDUFF no banco
        portal = PortalClient.new
        resposta = portal.login params[:usuario]
        usuario = Usuario.where(iduff: params[:usuario][:iduff]).first

        if resposta["autenticado"] == true
            if usuario
                session[:usuario_id] = usuario.id
                redirect_to root_path
            else
                redirect_to new_usuario_path, notice: "Cadastre-se para acessar o Sisac"
            end
        else
            flash.now[:alert] = "Matricula ou senha inválido."
            render action: "new"
        end
    end


#  def create
        
#     usuario = Usuario.where(iduff: params[:usuario][:iduff]).first
    
#     if usuario 
#        session[:usuario_id] = usuario.id
#        redirect_to root_path
#     else
#        flash.now[:alert] = "Matricula ou senha inválido."
#        render action: "new"
#     end
# end

    def destroy
        session[:usuario_id] = nil
        redirect_to login_path
    end

end