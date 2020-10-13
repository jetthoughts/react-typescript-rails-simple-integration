require 'amazing_print'
require_all './scripts'

module ScriptCrawler
  THIS_DIR = File.dirname(__FILE__)

  def generate_script_procs
    scripts = Dir["#{THIS_DIR}/scripts/*/*.rb"].select{|f| f !~ /spec/}
    ap scripts
  end
end
