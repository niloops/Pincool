# -*- coding: utf-8 -*-
require 'spec_helper'

describe Brand do
  let(:user) {FactoryGirl.create(:user)}

  before do
    @brand = Brand.new(title: "BrandNew",
                       logo: "http://image.url/image.png",
                       description: "Description",
                       uri: "brandnew",
                       user: user)
  end
  
  subject {@brand}

  it {should be_valid}
  describe "when title is not present" do
    before {@brand.title = ""}
    it {should_not be_valid}
  end

  describe "when logo is not present" do
    before {@brand.logo = ""}
    it {should_not be_valid}
  end

  describe "when description is not present" do
    before {@brand.description = ""}
    it {should_not be_valid}
  end

  describe "when uri is not present" do
    before {@brand.uri = ""}
    it {should_not be_valid}
  end

  describe "when edited by author" do
    it {should be_edited_by(user)}
  end

  describe "when edited by admin" do
    let(:admin) {FactoryGirl.create(:admin)}
    it {should be_edited_by(admin)}
  end

  describe "when edited by someone not author" do
    let(:other) {FactoryGirl.create(:user)}
    it {should_not be_edited_by(other)}
  end
  
end
