
class Usuario < ActiveRecord::Base
    has_and_belongs_to_many :perfis
    
	has_many :atividades
    
    validates_presence_of :iduff, :nome, :email
    validates_uniqueness_of :iduff
    # validates_length_of :senha, minimum: 6
    # validates_confirmation_of :senha


	# def senha=(nova_senha)
 #        @senha = nova_senha
 #    end

 #    def senha
 #        @senha
 #    end

end
