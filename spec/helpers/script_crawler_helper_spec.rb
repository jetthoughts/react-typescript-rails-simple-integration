require 'rails_helper'
require 'amazing_print'

describe 'ScriptCrawler' do
  include ScriptCrawler

  # THIS_DIR = File.dirname(__FILE__)
  context 'settings' do
    it 'should print schema' do
      files = ScriptCrawler.generate_script_procs_map
      ap files
    end
  end

end
