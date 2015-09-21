
class Usuario < ActiveRecord::Base
	
	belongs_to :professores
	belongs_to :alunos
    has_many :perfis
    has_many :declaracoes
    
	has_many :atividades
    
    validates_presence_of :iduff, :nome, :email
    validates_uniqueness_of :iduff


    def cria_aluno
        if self.alunos.empty?
            @aluno = Aluno.new(usuario: self)
            @aluno.save
        end
    end

    def cria_professor(avaliador)
        if self.professores.empty?
            @professor = Professor.new(usuario: self, avaliador: avaliador)
            @professor.save
        end
        if avaliador
            @professor.avaliador
            @professor.save
        end
    end

end
