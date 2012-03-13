require 'spec_helper'

describe Feeling do
  let(:author) {FactoryGirl.create(:user)}
  let(:brand) {FactoryGirl.create(:brand)}

  before do
    @feeling = Feeling.new(author: author,
                           brand: brand,
                           content: "content",
                           photos: [Photo.new(image: "/image.png")])
  end

  subject {@feeling}

  it {should be_valid}
  it {should_not respond_to :title}
  its(:author) {should == author}
  its(:brand) {should == brand}

  describe "Author has the post" do
    subject {author}
    its(:posts) {should include @feeling}
  end

  describe "Brand has the post" do
    subject {brand}
    its(:posts) {should include @feeling}
  end
end
