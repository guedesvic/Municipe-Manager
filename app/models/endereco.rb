class Endereco < ApplicationRecord
  belongs_to :municipe

  validates :estado, length: { is: 2, notice: "Dois caracteres permitidos" }
  
end