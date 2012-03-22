# -*- coding: utf-8 -*-
require 'spec_helper'

describe Brand do
  let(:user) {FactoryGirl.create(:user)}

  before do
    @brand = Brand.new(title: "BrandNew",
                       logo: "/image.png",
                       description: "Description",
                       uri: "brandnew",
                       founder: user)
  end

  subject {@brand}

  it {should be_valid}
  its(:founder) {should == user}
  it {should be_respond_to :eva_names}

  describe "Validation" do

    describe "when title is not present" do
      before {@brand.title = ""}
      it {should_not be_valid}
    end

    describe "when title is too long" do
      before {@brand.title = "a"*21}
      it {should_not be_valid}
    end

    describe "when uri is not present" do
      before {@brand.uri = ""}
      it {should_not be_valid}
    end

    describe "when uri is not match format" do
      before {@brand.uri = "sksdwdw_"}
      it {should_not be_valid}
    end

    describe "when uri is too short" do
      before {@brand.uri = "sk"}
      it {should_not be_valid}
    end

    describe "when uri is exist" do
      before do
        Brand.create(title: "BrandNew",
                     logo: "/image.png",
                     description: "Description",
                     uri: "brandnew",
                     founder: user)
      end
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

    describe "when description is too long" do
      before {@brand.title = "a"*141}
      it {should_not be_valid}
    end

    describe "when edited by author" do
      it {should be_edited_by(user)}
    end
  end

  describe "Edit authentication" do
    describe "when edited by admin" do
      let(:admin) {FactoryGirl.create(:admin)}
      it {should be_edited_by(admin)}
    end

    describe "when edited by someone not author" do
      let(:other) {FactoryGirl.create(:user)}
      it {should_not be_edited_by(other)}
    end

  end
end
