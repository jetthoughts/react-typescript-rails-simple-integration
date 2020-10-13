describe "wiki_print" do
  # include WikiIgrapherHelper
  include Scripts::WikiIgrapher
  # after() do
  #
  # end

  def get_wiki_sections(sections, depth, template = nil)
    wikiinput = {
        'sections' => sections,
        'template' => template,
        'depth' => depth,
        'layout' => 'default',
    }
    process_data wikiinput
  end

  THIS_DIR = File.dirname(__FILE__)
  context "settings" do
    it 'should print schema' do
      res = input_schema
      expect(res).to match_snapshot 'input_schema'
    end
  end
end
