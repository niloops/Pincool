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

  describe "message send" do
    describe "reveiver has messages" do
      subject {review.author.messages}
      its(:length) {should == 1}
    end
    
    subject {review.author.messages[0]}
    its(:type) {should == :comment}
    its(:senders) {should be_include author}
    its(:post) {should == review}
    its(:read) {should == false}

    describe "merge messages from same post" do
      before do
        @author_next = FactoryGirl.create(:user)
        @comment_next = Comment.new(author: @author_next, 
                                    content: "comment2")
        review.comments << @comment_next
      end

      specify {review.author.messages.count.should == 1}
      its(:senders) {should be_include author}
      its(:senders) {should be_include @author_next}
    end

    describe "read message" do
      before {Message.read_comment(review.author, review)}
      its(:read) {should == true}
    end

    describe "read all messages" do 
      before {Message.readall(review.author)}
      its(:read) {should == true}
    end
  end
end
