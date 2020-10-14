require 'rails_helper'

describe "/script", type: :request do
  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      assert_routing({path: 'script', method: :get}, {controller: 'script', action: 'index'})

      get script_url
      expect(response).to be_successful
      ap response
    end
  end

  describe "GET /:script_key.json" do
    it "renders a successful response" do
      assert_routing({path: 'script/kod', method: :get}, {controller: 'script', action: 'input_fetch', id: "kod"})

      ap script_url + "/kod"
      # get script_url + "/kod", {params: {input: {kod: 'sar'}}}
      # get script_url + "/kod", {params: {input: {params: 'sar'}}, format: 'json'}
      # get script_url + "/kod", {params: {input: {params: 'sar'}}}
      get script_url + "/kod.json", {params: {input: {params: 'sar'}}}
      expect(response).to be_successful
      body = response.body
      # ap body
      # puts JSON.pretty_generate(body)
      puts "\nJSON body:"
      ap body
      puts body
      ap JSON.parse(body)
      expect(body).to match_snapshot('GET-script_key.json')
      # puts body
      # ap response
      # ap response.inspect
    end
  end

end
