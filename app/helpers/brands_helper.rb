module BrandsHelper
  def logo_tag(brand, thumb)
    image_tag image_url(:logo, brand.logo, thumb),
    alt: brand.title,
    title: brand.title
  end
end
