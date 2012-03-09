# -*- coding: utf-8 -*-
class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :uri, type: String
  field :logo, type: String
  field :description, type: String

  belongs_to :user
  index :uri, unique: true
  index :created_at

  validates :title, presence: true
  validates :uri, presence: true
  validates :logo, presence: true
  validates :description, presence: true

  validates_presence_of :title,
  :message => "请输入页面名字" 
  validates_length_of :title,
  :within => 1..40,
  :too_short => "最少%{count}个字",
  :too_long => "最多%{count}个字"

  validates_presence_of :uri,
  :message => "请输入链接"
  validates_format_of :uri,
  :with => /^[0-9a-z-]+$/,
  :message => "网址仅限小写字母、数字与“-”"
  validates_length_of :uri,
  :within => 4..255,
  :message => '网址长度应在4-255个字符之间'
  validates_uniqueness_of :uri,
  :case_sensitive => false,
  :message => "此链接已被使用"

  paginates_per 20

  class << self
    def find_by_uri(uri)
      where(uri: uri).first
    end
  end

  def edited_by?(edit_user)
    edit_user.admin? || user == edit_user 
  end

  def to_param
    uri
  end
end
