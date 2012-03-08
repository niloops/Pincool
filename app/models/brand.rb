class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :logo_url, type: String
  field :description, type: String
  
  belongs_to :user

  validates :title, presence: true
  validates :logo_url, presence: true
  validates :description, presence: true
end
