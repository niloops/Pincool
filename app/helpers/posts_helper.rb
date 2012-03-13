module PostsHelper
  def photo_tag(photo, thumb)
    image_tag image_url(:photo, photo.image, thumb)
  end

  def author_avatar(author)
    image_tag author.image_url, 
    alt: author.name,
    title: author.name,
    class: "people_thumb_small"
  end
end
