# -*- coding: utf-8 -*-
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  embedded_in :post, inverse_of: :comments
  belongs_to :author, class_name: 'User'

  validates_presence_of :content, message: "回复不能为空"

  after_create :notify_related

  def editable_by?(user)
    user.admin? || author == user
  end

  private

  def related
    (post.comments.map {|comment| comment.author} << post.author).uniq
  end

  def notify_related
    related.each {|user| Message.build_comment(author, post).send_to(user)} 
  end
end
