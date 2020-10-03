require 'rails_helper'

RSpec.describe "WikiIgraphers", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/wiki_igrapher/index"
      expect(response).to have_http_status(:success)
    end
  end

end
