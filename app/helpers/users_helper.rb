module UsersHelper
  def provider_tag(user)
    link_to image_tag("provider/#{user.current_auth.provider}.png"),
    user.current_auth.link_url, target: '_blank'
  end
end
