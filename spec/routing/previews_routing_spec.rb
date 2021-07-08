require "rails_helper"

RSpec.describe PreviewsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/previews").to route_to("previews#index")
    end

    it "routes to #new" do
      expect(get: "/previews/new").to route_to("previews#new")
    end

    it "routes to #show" do
      expect(get: "/previews/1").to route_to("previews#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/previews/1/edit").to route_to("previews#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/previews").to route_to("previews#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/previews/1").to route_to("previews#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/previews/1").to route_to("previews#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/previews/1").to route_to("previews#destroy", id: "1")
    end
  end
end
