class AtividadePdf < Prawn::Document
	def initialize(atividades)
		super()
		@atividades = atividades
		header
		line_items
	end
end

def header
	bounding_box [bounds.left, bounds.top - 25], :width  => bounds.width do
	    move_down 32
	    font_size 14
	    text "SERVIÇO PÚBLICO FEDERAL", :align => :center
	    text "MINISTÉRIO DA EDUCAÇÃO", :align => :center
	    move_down 10
	    text "UNIVERSIDADE FEDERAL FLUMINENSE", :align => :center
	    move_down 40
	    font_size 24
	    text "RELATORIO DE ATIVIDADE COMPLEMENTAR", :align => :center, :style => :bold
		move_down 30
	end
end

def line_items
	move_down 20
	font_size 12
	table ([["Nome", "Status", "Professor", "Documento", "Aluno"]] +
	@atividades.collect{ |a| [a.nome, a.status, a.professor.to_s, a.documento.to_s, a.usuario.nome.to_s]})
	move_down 30
end

def footer
    bounding_box [bounds.right, bounds.bottom], :width  => bounds.width do
        font_size 14
        move_down 20
        text "Niterói,"
    end
end
