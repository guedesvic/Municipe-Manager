class AdminsBackoffice::SearchController < AdminsBackofficeController

  def municipes
    @municipes = Municipe.search(params[:page],params[:term])
  end

  def filtered_municipios
    @municipes = Municipe.filter_by_municipios(params[:page], params[:municipio_id])
  end
end
