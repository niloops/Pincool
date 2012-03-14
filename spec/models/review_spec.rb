require 'spec_helper'

describe Review do
  let(:author) {FactoryGirl.create(:user)}
  let(:brand) {FactoryGirl.create(:brand)}

  before do
    @review = Review.new(author: author,
                         brand: brand,
                         title: "title",
                         evas: [1,3,4],
                         content: "content",
                         photos: [Photo.new(image: "/image.png")])
  end

  subject {@review}

  it {should be_valid}
  it {should respond_to :title}

  describe "should has title" do
    before {@review.title = ""}
    it {should_not be_valid}
  end

  describe "should has evas" do
    before {@review.evas = []}
    it {should_not be_valid}
  end

  describe "evas should = 3" do
    before {@review.evas = [1, 2]}
    it {should_not be_valid}
  end

  describe "evas format check" do
    before {@review.evas = [1, 2, 11]}
    it {should_not be_valid}
  end

  describe "evas format check 2" do
    before {@review.evas = [0, 0, 0]}
    it {should_not be_valid}
  end

  describe "evas added to brand" do
    before {@review.save}
    its(:evas) {should == brand.evas}
  end
end
