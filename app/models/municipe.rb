class Municipe < ApplicationRecord
  
  belongs_to :municipio, inverse_of: :municipes
  has_many :enderecos, dependent: :delete_all
  accepts_nested_attributes_for :enderecos, reject_if: :all_blank, allow_destroy: true
  has_one_attached :avatar

  validates :cpf, length: { in: 11..14, message: "O tamanho maximo de caracteres de um CPF e 14." }
  validates :cns, numericality: { only_integer: true }, length: { is: 15, message: "A quantidade de digitos de uma CNS e 15" }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  after_create :send_registered_municipe_mail

  scope :search, ->(page,term) {
    includes(:municipio)
    .where("lower(municipes.nome) LIKE ?", "#{term.downcase}%")
    .page(page)
  }

  scope :registered_municipes, ->(page) {
    includes(:municipio)
    .order(:nome)
    .page(page)
  }

  scope :filter_by_municipios, ->(page, subject_id) {
    includes(:municipio)
    .where(municipio_id: subject_id)
    .page(page)
  }

  def self.translated_fields_for_status
    [["Ativo", true], ["Inativo", false]]
  end

  def send_registered_municipe_mail
    FactoryMailer.mail_generator(
      mailer_class: 'factory_mailer',
      mailer_template: 'registered_municipe_mail',
      title: "Cadastro realizado com sucesso",
      municipe: self
    ).deliver_now
  end
end
