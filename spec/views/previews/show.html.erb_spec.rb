require 'rails_helper'

RSpec.describe "previews/show", type: :view do
  before(:each) do
    @preview = assign(:preview, Preview.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
