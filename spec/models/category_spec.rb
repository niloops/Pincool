# -*- coding: utf-8 -*-
require 'spec_helper'

describe Category do

  before do
    @category = Category.new(name: "Category")
  end

  subject {@category}

  it {should be_valid}

  describe "Validation" do
    describe "when name is not present" do
      before {@category.name = ""}
      it {should_not be_valid}
    end

    describe "when name is too long" do
      before {@category.name = "a"*11}
      it {should_not be_valid}
    end

    describe "when category is exist" do
      before do
        Category.create(name: "Category")
      end
      it {should_not be_valid}
    end
  end
  
end
