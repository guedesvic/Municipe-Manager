module AdminsBackofficeHelper
  def avatar_url
    avatar = current_admin.avatar
    avatar.attached? ? avatar : 'img.jpg'
  end
end