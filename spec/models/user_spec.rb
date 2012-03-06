# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  before do
    @auth = Authentication.new(provider: "weibo",
                               uid: "exampleuid",
                               name: "foobar",
                               image_url: "http://image.com/image_url")
    @user = User.create_with_auth(@auth)
  end
  
  subject {@user}

  it {should be_valid}
  its(:name) {should == @auth.name}
  its(:image_url) {should == @auth.image_url}
  its(:token) {should_not be_blank}

  describe "find user by auth" do
    before {@user = User.find_by_auth(@auth)}
    its(:authentications) {should include @auth}
    its(:name) {should == @auth.name}
  end

  describe "find user by id with token" do
    before {@user = User.find_by_id_with_token(@user.id, @user.token)}
    it {should_not be_nil}
  end
end
