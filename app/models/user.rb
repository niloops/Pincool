class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :token, type: String
  field :admin, type: Boolean, default: false
  
  embeds_many :authentications
  index ["authentications.provider", "authentications.uid"]
  has_many :found_brands, class_name: 'Brand'
  has_and_belongs_to_many :followings, class_name: 'Brand'

  before_create :create_token

  class << self
    def find_by_auth(auth)
      where("authentications.provider" => auth.provider)
        .and("authentications.uid" => auth.uid).first
    end

    def find_by_id_with_token(id, token)
      user = find(id)
      (user.token == token) ? user : nil
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

  def current_auth=(auth)
    current_auth.update_attributes(current: false)
    target_auth = authentications.where(provider: auth.provider)
      .and(uid: auth.uid).first
    target_auth && target_auth.update_attributes(current: true,
                                                name: auth.name, image_url: auth.image_url)
  end

  def name
    current_auth.name
  end

  def image_url
    current_auth.image_url
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

  private

  def create_token
    self.token = SecureRandom.urlsafe_base64 if new?
  end
end
