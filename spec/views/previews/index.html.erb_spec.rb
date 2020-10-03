require 'rails_helper'

RSpec.describe "previews/index", type: :view do
  before(:each) do
    assign(:previews, [
      Preview.create!(),
      Preview.create!()
    ])
  end

  it "renders a list of previews" do
    render
  end
end
