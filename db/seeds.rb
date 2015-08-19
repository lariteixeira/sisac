# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# puts "Adicionando Tipos"

Perfil.transaction do
  File.open(File.expand_path("../../doc/lista_perfis.txt", __FILE__), "r") do |perfis|
    perfis.read.each_line do |perfil|
      array = perfil.split(/;/)
      unless Perfil.find_by_id(array[0].to_i)
        t = Perfil.create(:id => array[0].to_i, :nome => array[1].strip)
      end
    end
  end
end

puts "Criando usuário padrão"

Usuario.transaction do
  usuario = Usuario.where("iduff = '14735072780'")
  if usuario.blank?
    usuario = Usuario.new :nome=>"Larissa",
    				:iduff => "14735072780",
    				:email => "larissateixeira@id.uff.br",
            :categoria => "Aluno"
    usuario.save!
  end
end

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