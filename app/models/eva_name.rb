# -*- coding: utf-8 -*-
class EvaName
  include Mongoid::Document

  field :name, type: String
  field :type, type: Symbol
  
  validates_presence_of :name
  validates_presence_of :type
  validates_inclusion_of :type, in: [:r, :g, :b]
end
