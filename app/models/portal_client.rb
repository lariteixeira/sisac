class PortalClient

 include HTTParty
 
 if Rails.env == "producao"
 	base_uri "https://sistemas.uff.br/portal"
 else
    base_uri "http://homologacao.sti.uff.br/portal"
 end

 #base_uri = URL_DO_PORTAL
 
 def initialize

 end

 def login params
 	iduff = params[:iduff]
 	senha = params[:senha]

 	response = self.class.post(login_path, body: {iduff: iduff, senha: senha})
 	response.parsed_response
 end

 def login_path
 	"/ws/autenticacoes/login.json"
 end	



end
