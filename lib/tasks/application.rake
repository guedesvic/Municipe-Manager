require 'roo'

namespace :application do

  task create_admin: :environment do
    unless Admin.exists?(email: 'admin@admin.com')
      admin = Admin.new
      admin.email = 'admin@admin.com'
      admin.password = '123456'

      if admin.save!
        puts 'Admin criado com sucesso!'
      end
    end
  end

  task populate_municipios: :environment do
    municipios = Municipio.last
    
    if municipios.nil?
      puts 'Importando municipios'

      data = Roo::Spreadsheet.open('lib/municipios.xlsx')
      headers = data.row(1)

      data.each_with_index do |row, index|
        next if index == 0

        municipio_data = Hash[[headers, row].transpose]

        if Municipio.exists?(nome: municipio_data['municipio'])
          puts 'Municipio ja existe'
          next
        end

        municipio = Municipio.new
        municipio.nome = municipio_data['municipio']
        municipio.estado = municipio_data['uf']
        municipio.ibge = municipio_data['ibge']

        if municipio.save!
          puts 'Municipio criado'
        end
      end
    else
      puts 'Tabela de municipios ja populada'
    end
  end
end
