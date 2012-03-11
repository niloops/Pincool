# -*- coding: utf-8 -*-
class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :uri, type: String
  field :logo, type: String
  field :description, type: String
  index :uri, unique: true
  index :created_at

  belongs_to :founder, class_name: 'User', index: true, inverse_of: :found_brands
  has_and_belongs_to_many :followers, class_name: 'User'
  has_many :posts, validate: false

  validates :logo, presence: true
  validates :description, presence: true

  validates_presence_of :founder
  validates_presence_of :title, message: "品牌名称不能为空" 
  validates_length_of :title, within: 1..20, too_long: "名称最多只能输入%{count}个字"
  validates_presence_of :uri, message: "域名不能为空"
  validates_format_of :uri, with: /^[0-9a-z-]+$/, message: "域名仅限小写字母、数字与“-”"
  validates_length_of :uri, within: 4..255, message: '域名长度应在4-255个字符之间'
  validates_uniqueness_of :uri, case_sensitive: false, message: "此域名已被使用"
  validates_presence_of :logo, message: "请上传logo图片"
  validates_format_of :logo, with: /^\/[0-9a-z]+\.[a-z]+$/
  validates_presence_of :description, message: "一句话简介不能为空"
  validates_length_of :description, within: 1..140, too_long: "简介最多只能输入%{count}个字"

  after_create :followed_by_founder
  
  paginates_per 20

  class << self
    def find_by_uri(uri)
      where(uri: uri).first
    end
  end

  def edited_by?(edit_user)
    edit_user.admin? || founder == edit_user 
  end

  def followed_by?(user)
    followers.find(user.id)
  end

  def followed_by_founder
    founder.follow self
  end

  def to_param
    uri
  end
end
