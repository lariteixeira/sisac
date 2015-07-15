class UsuarioMailer < ApplicationMailer
	default from: 'larissateixeira92@gmail.com'

	def welcome_email(usuario)
		@usuario = usuario
		@url = '/login'
		mail(to: 'larissateixeira@id.uff.br',subject: 'Bem Vindo a SisAC')
	end
end
