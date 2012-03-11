FactoryGirl.define do

  factory :authentication do
    provider "weibo"
    sequence(:uid) {|n| "uid_#{n}"}
    sequence(:name) {|n| "person_#{n}"}
    sequence(:image_url) {|n| "http://weibo.com/images/#{n}.png"}
  end

  factory :user, aliases: [:founder] do
    factory :admin do
      admin true
    end

    after_create do |user|
      # user.authentications << Factory.create(:authentication)
    end
  end

  factory :brand do
    title "BrandNew"
    sequence(:uri) {|n| "uri#{n}"}
    logo "/img.png"
    description "Description"
    founder
  end
end
