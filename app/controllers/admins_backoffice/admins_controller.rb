class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: %i[ edit ]
  before_action :set_municipe, only: %i[ edit_registered_municipe ]

  def index
  end

  def municipes
    @municipes = Municipe.registered_municipes(params[:page])
  end

  def edit_registered_municipe
  end

  def edit
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  def municipe_params
    params.require(:municipe).permit(:nome, :cpf, :cns, :email, :data_nascimento, :telefone, :status, :receber_emails, :municipio_id,
      enderecos_attributes: [:id,:cep, :logradouro, :complemento, :bairro, :cidade, :estado, :ibge, :_destroy])
  end
end
