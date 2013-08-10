require 'spec_helper'

describe StaticPageController do

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'nearby'" do
    it "returns http success" do
      get 'nearby'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end

  describe "GET 'credits'" do
    it "returns http success" do
      get 'credits'
      response.should be_success
    end
  end

  describe "GET 'suggestions'" do
    it "returns http success" do
      get 'suggestions'
      response.should be_success
    end
  end

  describe "GET 'donate'" do
    it "returns http success" do
      get 'donate'
      response.should be_success
    end
  end

end
