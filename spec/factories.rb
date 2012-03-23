FactoryGirl.define do

  factory :authentication do
    provider "weibo"
    sequence(:uid) {|n| "uid_#{n}"}
    sequence(:name) {|n| "person_#{n}"}
    sequence(:image_url) {|n| "http://weibo.com/images/#{n}.png"}
  end

  factory :user, aliases: [:founder, :author] do
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

  factory :review do
    author
    brand
    title "Title"
    evas [1, 1, 1]
    content "content"
    photos [Photo.new(image: "/image.png")]
  end
end
