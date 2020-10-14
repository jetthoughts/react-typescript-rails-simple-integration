require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WikiIgrapherHelper. For example:
#
# describe WikiIgrapherHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe "WikiIgrapherHelper", type: :helper do
  pending "add some examples to (or delete) #{__FILE__}"
end

# require 'yaml'

describe "wiki_print" do
  # include WikiIgrapherHelper
  include Scripts::WikiIgrapher
  # after() do
  #
  # end

  def get_wiki_sections(sections, depth, template = nil)
    input_params = {
        'sections' => sections,
        'template' => template,
        'depth' => depth,
        'layout' => 'default',
    }
    run_script input_params
  end

  THIS_DIR = File.dirname(__FILE__)
  context "settings" do
    it 'should print schema' do
      res = input_schema
      expect(res).to match_snapshot 'input_schema'
    end
  end

  context "use" do
    it 'preset_slapshot_indiv' do
      sections = prepare_yml 'sections', THIS_DIR
      template = prepare_yml 'template', THIS_DIR
      res = get_wiki_sections sections, 3, template
      expect(res.to_yaml).to match_snapshot 'preset_slapshot_indiv'
    end

    it 'preset_eeylops_slapshot_combined' do
      sections = prepare_yml 'eeylops_slapshot_combined', THIS_DIR
      res = get_wiki_sections sections, 2
      expect(res).to match_snapshot 'preset_eeylops_slapshot_combined'
    end

    it 'preset_eeylops_slapshot_indiv' do
      sections = prepare_yml 'eeylops_slapshot_sections', THIS_DIR
      template = prepare_yml 'eeylops_slapshot_template', THIS_DIR
      res = get_wiki_sections sections, 0, template
      expect(res).to match_snapshot 'preset_eeylops_slapshot_indiv'
    end
  end

  context 'util' do
    it 'should add comments' do
      @wiki = []
      res = make_comment 'yml_str', 'title'
      expect(res).to match_array(["{{comment}}", "\nTitle\n", "=====", "yml_str", "{{/comment}}", "#{Scripts::WikiIgrapher::HTML_BREAK*2}"])
    end
  end
end
