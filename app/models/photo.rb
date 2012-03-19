class Photo
  include Mongoid::Document
  field :image, type: String
  field :width, type: Integer
  field :height, type: Integer

  embedded_in :post, :inverse_of => :photos

  validates_presence_of :image
end
