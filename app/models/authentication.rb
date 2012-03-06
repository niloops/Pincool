class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :image_url, type: String
  field :current, type: Boolean, default: false
  embedded_in :user

  validates :provider, presence: true
  validates :uid, presence: true
  validates :name, presence: true

  class << self
    def build_with_omniauth(auth)
      provider_method = auth[:provider].to_sym

      fields = (respond_to? provider_method) ?
      (send provider_method, auth) :
        provider_default(auth)

      new fields.merge(provider: auth[:provider])
    end

    def weibo(auth)
      provider_default(auth)
        .merge(uid: auth[:extra][:raw_info][:id])
    end

    def provider_default(auth)
      {uid: auth[:uid],
        name: auth[:info][:name],
        image_url: auth[:info][:image]}
    end

  end
end
