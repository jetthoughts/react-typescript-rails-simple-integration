describe "WikiIgrapher" do
  include Scripts::WikiIgrapher

  def compute(sections, depth, template = nil)
    input = {
        'sections' => sections,
        'template' => template,
        'depth' => depth,
        'layout' => 'default',
    }
    run_script input
  end

  THIS_DIR = File.dirname(__FILE__)
  context "settings" do
    it 'should print schema' do
      res = input_schema
      expect(res.to_yaml).to match_snapshot 'input_schema'
    end
  end
end
