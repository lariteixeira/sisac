class AtividadePdf < Prawn::Document
	def initialize(atividades)
		super()
		@atividades = atividades
		header
		line_items
		footer
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
	data = [["Nome", "Status", "Professor", "Documento", "Aluno"]] +
	@atividades.collect{ |a| [a.nome, a.status, a.professor.to_s, a.documento.to_s, a.usuario.nome.to_s]}
	table (data), :row_colors => ["DDDDDD", "FFFFFF"]
	move_down 30
end

def footer
    font_size 14
    move_down 200
    date = Time.now.strftime("%d-%m-%Y - %H:%M:%S")
    text "Niterói, " + date, :align => :center
    font_size 8
    move_down 10
    chave_gerada = Digest::SHA1.hexdigest(Time.now.to_s)[0..15].upcase
    chave_gerada = chave_gerada[0..3] + "." + chave_gerada[4..7] + "." + chave_gerada[8..11] + "." + chave_gerada[12..15]
    text chave_gerada, :align => :center
end
