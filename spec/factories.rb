FactoryGirl.define do

  factory :authentication do
    provider "weibo"
    sequence(:uid) {|n| "uid_#{n}"}
    sequence(:name) {|n| "person_#{n}"}
    sequence(:image_url) {|n| "http://weibo.com/images/#{n}.png"}
  end

  factory :user do
    admin true

    after_create do |user|
      # user.authentications << Factory.create(:authentication)
    end
  end

  # factory :micropost do
  #   content "Lorem ipsum"
  #   user
  # end
end
