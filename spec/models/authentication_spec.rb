# -*- coding: utf-8 -*-
require 'spec_helper'

describe Authentication do
  before do
    @auth = Authentication.new(provider: "weibo",
                               uid: "exampleuid",
                               name: "foobar")
  end
  
  subject {@auth}

  it {should be_valid}

  describe "when provider is not present" do
    before {@auth.provider = ""}
    it {should_not be_valid}
  end

  describe "when uid is not present" do
    before {@auth.uid = ""}
    it {should_not be_valid}
  end

  describe "when name is not present" do
    before {@auth.name = ""}
    it {should_not be_valid}
  end

  describe "build from weibo" do
    before do
      File.open('spec/weibo_marshal') do |f|
        weibo = Marshal.load(f)
        @auth = Authentication.build_with_omniauth(weibo)
      end
    end

    it {should be_valid}
    its(:provider) {should == "weibo"}
    its(:uid) {should == "1218520492"}
    its(:name) {should == "_李路"}
    its(:image_url) {should == "http://tp1.sinaimg.cn/1218520492/50/1259132207/1"}
  end
  
end
