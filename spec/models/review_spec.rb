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
  it {should respond_to :evaluated?}

  describe "should has title" do
    before {@review.title = ""}
    it {should_not be_valid}
  end

  describe "should has evas" do
    before {@review.evas = []}
    it {should_not be_valid}
  end

  describe "should not valid evas when not evaluated?" do
    before do
      @review.evas = []
      @review.evaluated = false
    end
    it {should be_valid}
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

  describe "Brand evas" do
    before do
      @review.save
      @review_next = Review.new(author: author,
                           brand: brand,
                           title: "title",
                           evas: [2,5,6],
                           content: "content",
                           photos: [Photo.new(image: "/image.png")])
      @review_next.save
    end

    subject {brand}
    its(:total_evas) {should == (0..2).map {|i| @review.evas[i]+@review_next.evas[i]}}
    its(:evas) {should == (0..2).map {|i| brand.total_evas[i]/2}}

    
    describe "evas changed to brand" do
      before do
        @review_next.evas = [4, 8, 10]
        @review_next.save
      end
      its(:total_evas) {should == (0..2).map {|i| @review.evas[i]+@review_next.evas[i]}}
    end

    describe "evas destroyed to brand" do
      before do
        @review_next.destroy
      end
      its(:total_evas) {should == @review.evas}
    end

    describe "review change to unevaluated" do
      before do
        @review_next.evas = []
        @review_next.evaluated = false
        @review_next.save
      end
      its(:total_evas) {should == @review.evas}
      its(:evas) {should == @review.evas}
    end
    
  end
end
