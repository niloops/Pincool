class InvitedUser
  include Mongoid::Document
  field :provider, type: String
  field :name, type: String

  validates :provider, presence: true
  validates :name, presence: true

  class << self
    def find_by_provider_and_name(provider, name)
      where(provider: provider, name: name).first
    end
  end

  def registered_user
    User.where("authentications.provider" => provider)
      .and("authentications.name" => name).first
  end
end
