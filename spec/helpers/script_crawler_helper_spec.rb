require 'rails_helper'
require 'amazing_print'

describe 'ScriptCrawler' do
  include ScriptCrawler

  # THIS_DIR = File.dirname(__FILE__)
  context 'settings' do
    it 'should print schema' do
      files = generate_script_procs_map
      ap files
    end
  end


  # context 'util' do
  #   it 'should add comments' do
  #     @wiki = []
  #     res = make_comment 'yml_str', 'title'
  #     expect(res).to match_array(["{{comment}}", "\nTitle\n", "=====", "yml_str", "{{/comment}}", "#{WikiIgrapherHelper::HTML_BREAK*2}"])
  #   end
  # end
end
