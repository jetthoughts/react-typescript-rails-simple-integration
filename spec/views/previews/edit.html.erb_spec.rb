require 'rails_helper'

RSpec.describe "previews/edit", type: :view do
  before(:each) do
    @preview = assign(:preview, Preview.create!())
  end

  it "renders the edit preview form" do
    render

    assert_select "form[action=?][method=?]", preview_path(@preview), "post" do
    end
  end
end
