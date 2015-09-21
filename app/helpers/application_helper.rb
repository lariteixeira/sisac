module ApplicationHelper
	def tem_comprovante(doc)
		if doc.blank?
			"Não"
		else
			"Sim"
		end
	end

	# def nome_professor(index)
		
	# 	professor = Usuario.where(id: index.to_i).first
	# 	if professor.blank?
	# 		"a definir"
	# 	else
	# 		professor.nome
	# 	end

	# end
	
end
