class ZipCodeService
  include HTTParty
  default_timeout 2

  attr_accessor :zip_code, :response, :final_json

  def initialize zip_code
    @zip_code = zip_code
    @final_json = {}
  end

  def get_via_cep
    r = self.class.get("https://viacep.com.br/ws/#{zip_code}/json/")

    if r.response.code == '200'
      {
        neighborhood: 'bairro',
        city_name: 'localidade',
        street_name: 'logradouro',
        state_name: 'uf'
      }.each do |k, v|
        if k != :state_name
          final_json[k] = r[v]
        else
          final_json[k] = State.find_by_uf(r[v]).name
        end
      end
      final_json[:country] = 'brazil'
    else
      raise 'Request error'
    end
  end
  # VIA CEP RESPONSE:
  # {
  #   "cep": "22441-090",
  #   "logradouro": "Rua General Venâncio Flores",
  #   "complemento": "",
  #   "bairro": "Leblon",
  #   "localidade": "Rio de Janeiro",
  #   "uf": "RJ",
  #   "unidade": "",
  #   "ibge": "3304557",
  #   "gia": ""
  # }
end