class CreateEnderecos < ActiveRecord::Migration[5.2]
  def change
    create_table :enderecos do |t|
      t.references :municipe, foreign_key: true
      t.string :cep, null: false
      t.string :logradouro, null: false
      t.string :complemento
      t.string :bairro, null: false
      t.string :cidade, null: false
      t.string :estado, null: false
      t.integer :ibge

      t.timestamps
    end
  end
end
