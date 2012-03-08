# -*- coding: utf-8 -*-
require 'spec_helper'

describe Brand do
  let(:user) {FactoryGirl.create(:user)}

  before do
    @brand = Brand.new(title: "BrandNew",
                       logo_url: "http://image.url/image.png",
                       description: "Description",
                       user: user)
  end
  
  subject {@brand}

  it {should be_valid}
  describe "when title is not present" do
    before {@brand.title = ""}
    it {should_not be_valid}
  end

  describe "when logo_url is not present" do
    before {@brand.logo_url = ""}
    it {should_not be_valid}
  end

  describe "when description is not present" do
    before {@brand.description = ""}
    it {should_not be_valid}
  end
end
