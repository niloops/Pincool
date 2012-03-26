# -*- coding: utf-8 -*-
module PostsHelper
  def post_desc(post)
    if post.respond_to? :evaluated 
      post.evaluated? ? "的产品评价" : "想要的产品"
    elsif post.type == "Feeling"
      "的感受分享"
    end
  end
  
  def photo_tag(photo, thumb)
    image_tag image_url(:photo, photo.image, thumb)
  end

  def author_avatar(author)
    image_tag author.image_url,
    alt: author.name,
    title: author.name,
    "class" => "people_thumb_small"
  end
end
