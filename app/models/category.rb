# -*- coding: utf-8 -*-
class Category
  include Mongoid::Document

  field :name, type: String
  belongs_to :founder, class_name: 'User'
  has_and_belongs_to_many :brands, validate: false

  validates_presence_of :name, message: "名称不能为空"
  validates_length_of :name, within: 2..10,
  too_short: "名称最少需要输入%{count}个字", too_long: "名称最多只能输入%{count}个字"
  validates_uniqueness_of :name, case_sensitive: false, message: "此名称已被使用"
end
