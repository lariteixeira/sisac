class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 
private
    def usuario_atual
      @usuario_atual ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]
    end
    helper_method :usuario_atual

     
    def authorize_usuario
        unless usuario_atual
          redirect_to login_path, alert: "Faça o login para continuar."
        end
    end

    def check_usuario
      if usuario_atual
        redirect_to root_path
      end
    end

    
  #   def configura_e_produz_relatorio(nome_arquivo, nome_relatorio)
  #   respond_to do |format|
  #     format.xls
  #     format.pdf { render :pdf => "#{nome_arquivo}_#{DateTime.now.in_time_zone.strftime "%d%m%Y%H%M%S"}",
  #                         :orientation => "Landscape", #Se portrait o titulo do relatorio nao cabe e quebra.
  #                         :footer => {
  #                             :right => 'Página [page] de [topage]',
  #                             :left => "SisAC - Sistema de Atividade Complementar / UFF",
  #                             :spacing => 2,
  #                             :save_only => true},
  #                         :header => {
  #                             :center => "#{nome_relatorio}",
  #                             :left => "SisAC - UFF",
  #                             :right => l(DateTime.now.in_time_zone),
  #                             :spacing => 2,
  #                             :font_size => 14
  #                         } }
  #   end
  # end
end