require 'rails_helper'

describe '/script', type: :request do
  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    {}
  }

  describe 'GET /index' do
    it 'renders a successful response' do
      assert_routing({ path: 'script', method: :get }, { controller: 'script', action: 'index' })

      get script_url
      expect(response).to be_successful
      # ap response
      get "#{script_url}.json"
      expect(response).to be_successful
      body = response.body
      puts "\nJSON body:"
      ap JSON.parse(body)
      expect(body).to match_snapshot("GET-index.json")
    end
  end

  describe 'GET /:script_key.json' do
    it 'does not render an unsuccessful response' do
      assert_routing({ path: 'script/kod', method: :get }, { controller: 'script', action: 'input_fetch', id: 'kod' })
      expect { get script_url + '/kod.json', { params: { input: { params: 'sar' } } } }.to raise_error(ArgumentError)
    end

    it 'renders a successful response: wiki_igrapher' do
      ROUTE = "wiki_igrapher"
      url = "#{script_url}/#{ROUTE}"
      assert_routing({ path: url, method: :get }, { controller: 'script', action: 'input_fetch', id: ROUTE })

      get "#{url}.json", { params: { input: { params: 'sar', script: ROUTE } } }
      expect(response).to be_successful
      body = response.body
      puts "\nJSON body:"
      ap JSON.parse(body)
      expect(body).to match_snapshot("GET-script_key-#{ROUTE}.json")
    end
  end

  describe 'POST /:script_key.json' do
    it 'renders a successful response' do
      ROUTE = "wiki_igrapher"
      url = "#{script_url}/#{ROUTE}"
      assert_routing({ path: url, method: :post }, { controller: 'script', action: 'output_fetch', id: ROUTE })

      input_params_yml =
          # {}
          read_yml 'eg1', './app/helpers/scripts/wiki_igrapher/'
      input_params = YAML.load input_params_yml
      # ap input_params_yml
      # ap input_params
      inp = { input_params: input_params.to_json, script: ROUTE }
      ap inp
      # post "#{url}.json", { params: { input: { input_params: input_params, script: ROUTE } } }
      post "#{url}.json", { params: { input: inp } }
      expect(response).to be_successful

      body = response.body
      puts "\nJSON body:"
      ap JSON.parse(body)
      expect(body).to match_snapshot("POST-script_key-#{ROUTE}.json")
    end

    def read_yml(filename, dir)
      File.read("#{dir}/data/#{filename}.yml")
    end
  end
end
