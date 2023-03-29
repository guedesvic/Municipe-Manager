class Municipio < ApplicationRecord

  has_many :municipes
  
  validates :estado, length: { is: 2, too_long: "%{count} caracteres e o maximo" }
end
