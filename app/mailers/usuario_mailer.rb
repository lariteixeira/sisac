class UsuarioMailer < ApplicationMailer
	default from: 'no_reply@sisac.com.br'

	def novo_pedido_email(usuario, status)
		@usuario = usuario
		@status = status
		@url = 'www.sisac.uff.br'
		mail(to: 'larissateixeira@id.uff.br',subject: 'Pedido de avaliação de Atividade Complementar- SisAC')
	end
end
