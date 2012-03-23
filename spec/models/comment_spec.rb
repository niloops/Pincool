require 'spec_helper'

describe Comment do
  let(:author) {FactoryGirl.create(:user)}
  let(:review) {FactoryGirl.create(:review)}

  before do
    @comment = Comment.new(author: author,
                           content: "comment")
    review.comments << @comment
  end

  subject {@comment}
  
  it {should be_valid}
  its(:post) {should == review}

  describe "review should has comment"  do
    subject {review}
    its(:comments) {should be_include @comment}
  end

  describe "should has content" do
    before {@comment.content = ""}
    it {should_not be_valid}
  end
end
