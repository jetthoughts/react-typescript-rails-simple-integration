require 'amazing_print'
# require_all './scripts/**/*.rb'
require_rel 'i_script'
require_rel '*/*.rb'


module ScriptCrawler
  THIS_DIR = File.dirname(__FILE__)

  def self.generate_script_procs_map
    map2 = {}
    scripts_files = Dir["#{THIS_DIR}/*/*.rb"].reject { |f| f =~ /spec/ }
    scripts_files.each do |f|
      file_name = File.basename(f, ".*")
      ff = file_name.camelize
      ffc = "Scripts::#{ff}Script".constantize
      map2[file_name] = ffc.new
    end
    # ap map2
    map2
  end

  # SCRIPTS_MAP = generate_script_procs_map
  SCRIPTS_MAP = ScriptCrawler.generate_script_procs_map # todo: hmmm

  def generate_script_class_map
    scripts = Scripts.constants
                     .select { |c| Scripts.const_get(c).is_a? Class }
                     .reject { |c| Scripts.const_get(c).name =~ /IScript/ }
    map = {}
    scripts.each{|c| map[c] = Scripts.const_get(c).new}
    map
  end
end
