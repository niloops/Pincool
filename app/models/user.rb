class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :token, type: String
  field :admin, type: Boolean, default: false
  
  embeds_many :authentications
  has_many :brands
  index ["authentications.provider", "authentications.uid"]

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

  def name
    current_auth.name
  end

  def image_url
    current_auth.image_url
  end

  private

  def create_token
    self.token = SecureRandom.urlsafe_base64 if new?
  end
end
