class CreateMunicipes < ActiveRecord::Migration[5.2]
  def change
    create_table :municipes do |t|
      t.references :municipio, foreign_key: true
      t.string :nome, null: false
      t.string :cpf, null: false
      t.string :cns, null: false
      t.string :email, null: false
      t.date :data_nascimento, null: false
      t.string :telefone
      t.boolean :status, null: false
      t.boolean :receber_emails, null: false
      
      t.timestamps
    end
  end
end
