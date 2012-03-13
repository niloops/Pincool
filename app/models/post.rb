class Post
  include Mongoid::Document
  include Mongoid::Timestamps
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

  def edited_by?(edit_user)
    edit_user.admin? || author == edit_user 
  end
end
