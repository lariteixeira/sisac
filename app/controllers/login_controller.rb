class LoginController < ApplicationController

    def new

    end

    def create
        portal = PortalClient.new
        #Autentica o usuario no portal do IdUFF
        resposta = portal.login params[:usuario]
        #Confere se o usuario esta cadastrado no banco do SISAC
        usuario = Usuario.where(iduff: params[:usuario][:iduff]).first
        if usuario || resposta["autenticado"] == true
            
            if usuario
                session[:usuario_id] = usuario.id
                redirect_to root_path
            else
                redirect_to new_usuario_path, notice: "Cadastre-se para acessar o SISAC"
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