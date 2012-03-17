# -*- coding: utf-8 -*-
module CategoriesHelper
  def category_brands_tag(category)
    titles = category.brands.limit(3).map {|brand| brand.title}
    titles.join('/')+"等#{category.brands.count}个品牌" if titles.count > 0
  end
end
