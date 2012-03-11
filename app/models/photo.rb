class Photo
  include Mongoid::Document
  field :image, type: String

  embedded_in :post, :inverse_of => :photos

  validates_presence_of :image
end
