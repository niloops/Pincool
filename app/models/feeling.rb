# -*- coding: utf-8 -*-
class Feeling < Post
  field :content, type: String

  validates_length_of :content, maximum: 65535
  validates_length_of :photos, minimum: 1,
  too_short: "请上传图片"
end
