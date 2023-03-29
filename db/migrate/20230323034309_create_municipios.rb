class CreateMunicipios < ActiveRecord::Migration[5.2]
  def change
    create_table :municipios do |t|
      t.string :nome, null: false
      t.string :estado, null: false
      t.integer :ibge, null: false

      t.timestamps
    end
  end
end
