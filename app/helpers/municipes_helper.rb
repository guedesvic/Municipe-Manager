module MunicipesHelper
  def municipe_avatar_url(municipe)
    avatar = municipe.avatar
    avatar.attached? ? avatar : 'img.jpg'
  end
end
