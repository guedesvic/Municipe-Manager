class MunicipesController < ApplicationController
  before_action :set_municipe, only: %i[ show edit update destroy ]

  def index
    @municipes = Municipe.all
  end

  def show
  end

  def new
    @municipe = Municipe.new
  end

  def edit
  end

  def create
    @municipe = Municipe.new(municipe_params)
    
    if @municipe.save
      #message = "Seu cadastro foi realizado com sucesso"
      #TwilioTextMessenger.new(message).call
      
      redirect_to root_path, notice: "Registro realizado com sucesso!"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @municipe.update(municipe_params)
      
      FactoryMailer.mail_generator(
        mailer_class: 'factory_mailer',
        mailer_template: 'attributes_updated_mail',
        title: "Seu cadastro foi atualizado",
        municipe: @municipe
      ).deliver_now

      redirect_to (admin_signed_in? ? admins_backoffice_admins_municipes_path : municipe_url(@municipe))
    else
      redirect_to (admin_signed_in? ?  admins_backoffice_path(@municipe) : edit_municipe_path(@municipe))
    end
  end

  private
    def set_municipe
      @municipe = Municipe.find(params[:id])
    end

    def municipe_params
      params.require(:municipe).permit(:nome, :cpf, :cns, :email, :data_nascimento, :telefone, :status, :receber_emails, :municipio_id,
                    :avatar, enderecos_attributes: [:id,:cep, :logradouro, :complemento, :bairro, :cidade, :estado, :ibge, :_destroy])
    end
end
