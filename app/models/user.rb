class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :token, type: String
  field :admin, type: Boolean, default: false

  embeds_many :authentications
  index ["authentications.provider", "authentications.uid"]
  has_many :found_brands, class_name: 'Brand', inverse_of: :founder
  has_and_belongs_to_many :followings, class_name: 'Brand'
  has_many :posts, inverse_of: :author, validate: false
  embeds_many :messages

  before_create :create_token

  DELEGATED_AUTH_METHODS = [:name, :image_url, :image_big_url]

  class << self
    def find_by_auth(auth)
      where("authentications.provider" => auth.provider)
        .and("authentications.uid" => auth.uid).first
    end

    def find_and_update_by_auth(auth)
      user = find_by_auth(auth)
      return unless user
      user.update_auth auth
      user
    end

    def find_by_id_with_token(id, token)
      user = find(id)
      (user && user.token == token) ? user : nil
    end

    def create_with_auth(auth)
      create do |doc|
        auth.current = true
        doc.authentications << auth
      end
    end
  end

  def current_auth
    authentications.where(current: true).first
  end

  def update_auth(auth)
    current_auth.update_attributes(current: false)
    authentications.where(provider: auth.provider)
      .and(uid: auth.uid).destroy_all
    auth.current = true
    authentications << auth
  end

  def method_missing(name, *args)
    (DELEGATED_AUTH_METHODS.include? name) ?
    current_auth.send(name, *args) :
      super
  end

  def follow(brand)
    followings.find(brand.id) && return
    followings << brand
    brand.followers << self
  end

  def unfollow(brand)
    followings.delete brand
    brand.followers.delete self
  end

  def follow_posts
    Post.any_in(brand_id: following_ids)
  end

  private

  def create_token
    self.token = SecureRandom.urlsafe_base64 if new?
  end
end
