class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :content, type: String
  belongs_to :author, class_name: 'User',
  index: true, inverse_of: :posts
  belongs_to :brand,
  index: true, inverse_of: :posts
  index :created_at
  alias type _type

  embeds_many :photos

  validates_presence_of :author
  validates_presence_of :brand
  validates_presence_of :type
  validates_length_of :content, maximum: 65535

  paginates_per 5

  default_scope desc(:created_at)

  scope :by_type, ->(type) do
    type ? where(_type: type.capitalize) : scoped
  end

  class << self
    def get_class(type)
      Kernel.const_get(type.capitalize)
    end
  end

  def edited_by?(edit_user)
    edit_user.admin? || author == edit_user 
  end

  def title_required?
    !self.class.validators_on(:title).blank?
  end

end
