# -*- coding: utf-8 -*-
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  embedded_in :post, inverse_of: :comments
  belongs_to :author, class_name: 'User'

  validates_presence_of :content, message: "回复不能为空"

  def editable_by?(user)
    user.admin? || author == user
  end
end
