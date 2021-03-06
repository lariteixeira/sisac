class RelatorioPdf < Prawn::Document
  
  def initialize(declaracao, view, hora)
    super()
    @hora = hora
    @declaracao = declaracao
    @view = view
    header
    solicitante_info
    tabela_items
    @mes = String.mes(@hora.month)
    footer
  end

  def header
    bounding_box [bounds.left, bounds.top - 25], :width  => bounds.width do
        move_down 28
        font_size 14
        text "SERVIÇO PÚBLICO FEDERAL", :align => :center
        move_down 10
        text "MINISTÉRIO DA EDUCAÇÃO", :align => :center
        move_down 10
        text "UNIVERSIDADE FEDERAL FLUMINENSE", :align => :center
        move_down 40
        font_size 24
        text "Relatório de Atividades", :align => :center, :style => :bold
    end
  end

  def solicitante_info
    bounding_box [bounds.left + 20, bounds.top - 200], :width => (bounds.width - 40) do
      font_size 14
      font "Times-Roman"
      text "Relatório solicitado por: #{@declaracao.usuario.nome}"
    end
  end

  def tabela_items
    bounding_box [bounds.left + 20, bounds.top - 250], :width => (bounds.width - 40)  do
       font_size 13
       font "Times-Roman"
       data = @declaracao.tabela
       table (data), :row_colors => ["DDDDDD", "FFFFFF"]
       font_size 35
       move_down 50
    end
  end

  def footer
      bounding_box [bounds.left, bounds.bottom + 100 ], :width  => bounds.width do
        font_size 14
        fill_color(0, 0, 0, 100)
        move_down 20
        text "Niterói, #{@hora.day} de #{@mes} de #{@hora.year} às #{@hora.strftime("%H:%M:%S")}", :align => :center
        move_down 20
        font_size 7
        text "Este documento foi gerado pelo Sistema de Atividades Complementar - SISAC.", :align => :center
      end
  end
end