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

  def evas_tag(evas)
    evas ||= [5, 5, 5]
    content_tag(:ul, "class" => "evaluation") do
      {sensibility: evas[0],
        rationality: evas[1],
        economy: evas[2]}.map do |name, value|
        content_tag(:li, "class" => name.to_s )
      end.join
    end
  end
  # %ul.evaluation
  #   %li.sensibility{"data-name"=>"印象", "data-value"=>"7", "data-max"=>"10", "data-desc"=>"外观/设计/印象 7/10"}
  #   %li.rationality{"data-name"=>"内涵", "data-value"=>"8", "data-max"=>"10", "data-desc"=>"性能/质量/内涵 8/10"}
  #   %li.economy{"data-name"=>"实惠", "data-value"=>"9", "data-max"=>"10", "data-desc"=>"经济/实用/方便 9/10"}
end
