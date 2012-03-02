# -*- coding: utf-8 -*-
require 'spec_helper'

describe "StaticPages" do
  subject {page}

  describe "home" do
    before {visit root_path}
    it {should have_selector 'h1', text: '品酷'}
  end
end
