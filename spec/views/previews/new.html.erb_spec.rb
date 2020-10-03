require 'rails_helper'

RSpec.describe "previews/new", type: :view do
  before(:each) do
    assign(:preview, Preview.new())
  end

  it "renders new preview form" do
    render

    assert_select "form[action=?][method=?]", previews_path, "post" do
    end
  end
end
