# -*- coding: utf-8 -*-
module BrandsHelper
  def logo_tag(brand, thumb)
    image_tag image_url(:logo, brand.logo, thumb),
    alt: brand.title,
    title: brand.title
  end

  def follow_button_tag(brand)
    follow_text, unfollow_text = "订阅", "退订"
    follow_title = "订阅后,可在我的主页上查看此品牌更新"
    unfollow_title = "退订后,我的主页上将不会收到此品牌更新"
    if current_user && brand.followed_by?(current_user)
      button_tag unfollow_text, title: unfollow_title,
      'id' => 'follow_toggle',
      'class' => "unfollow",
      'data-url' => follow_toggle_brand_path(brand),
      'data-toggle-class' => "follow",
      'data-toggle-text' => follow_text,
      'data-toggle-title' => follow_title
    else
      button_tag follow_text, title: follow_title,
      'id' => 'follow_toggle',
      'class' => "follow",
      'data-toggle-class' => "unfollow",
      'data-url' => follow_toggle_brand_path(brand),
      'data-toggle-text' => unfollow_text,
      'data-toggle-title' => unfollow_title
    end
  end

  def categories_for_select
    Category.all.map {|c| [c.name, c.id]}
  end

  def eva_names_for_select(type)
    EvaName.where(type: type.to_sym).map {|e| e.name}
  end
end
