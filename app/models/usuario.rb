
class Usuario < ActiveRecord::Base
	has_many :atividades
    validates_presence_of :matricula, :nome, :categoria, :email
    validates_uniqueness_of :matricula
    validates_length_of :password, minimum: 6
    validates_confirmation_of :password

	def password=(new_password)
        @password = new_password
    end

    def password
        @password
    end

end
