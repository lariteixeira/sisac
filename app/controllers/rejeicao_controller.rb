class RejeicaoController < ApplicationController

  	before_action :set_atividade, only: [:show, :edit, :update, :destroy]

	def edit
	end

	def update
	  if @atividade.update_attributes({status: params[:status], motivo: params[:motivo]})
	      #enviar email
	      redirect_to atividades_path, notice: 'Atividade foi atualizada.'
	  else
	  	render json: @atividade.errors, status: :unprocessable_entity
	  end
	end

	  private
    # Use callbacks to share common setup or constraints between actions.
    def set_atividade
      @atividade = Atividade.find(params[:id])
    end

    def atividade_params
      params.require(:atividade).permit(:nome, :status, :professor, :motivo)
    end
end
