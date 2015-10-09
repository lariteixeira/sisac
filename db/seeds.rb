# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Adicionando Perfis de Usuario"

Perfil.transaction do
  File.open(File.expand_path("../../doc/lista_perfis.txt", __FILE__), "r") do |perfis|
    perfis.read.each_line do |perfil|
      array = perfil.split(/;/)
      unless Perfil.where(:id => array[0].to_i).first
        t = Perfil.create(:id => array[0].to_i, :nome => array[1].strip)
      end
    end
  end
end

puts "Adicionando Tipos de Atividade"

TipoAtividade.transaction do
  File.open(File.expand_path("../../doc/lista_atividades.txt", __FILE__), "r") do |tipoAtividades|
    tipoAtividades.read.each_line do |tipoAtividade|
      array = tipoAtividade.split(/;/)
      unless TipoAtividade.where(:id => array[0].to_i).first
        t = TipoAtividade.create(:id => array[0].to_i, :nome => array[1].strip)
      end
    end
  end
end

puts "Criando usuário padrão"


Usuario.transaction do
  usuario = Usuario.where("iduff = '1234567901'")
  if usuario.blank?
    usuario = Usuario.new :nome=>"Sisac",
            :iduff => "1234567901",
            :email => "sisac@sisac.com.br",
            :avaliador => true,
            :categoria => "Professor"
    usuario.save!
  end
end