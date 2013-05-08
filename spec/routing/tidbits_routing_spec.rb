require "spec_helper"

describe TidbitsController do
  describe "routing" do

    it "routes to #index" do
      get("/tidbits").should route_to("tidbits#index")
    end

    it "routes to #new" do
      get("/tidbits/new").should route_to("tidbits#new")
    end

    it "routes to #show" do
      get("/tidbits/1").should route_to("tidbits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/tidbits/1/edit").should route_to("tidbits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/tidbits").should route_to("tidbits#create")
    end

    it "routes to #update" do
      put("/tidbits/1").should route_to("tidbits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/tidbits/1").should route_to("tidbits#destroy", :id => "1")
    end

  end
end
