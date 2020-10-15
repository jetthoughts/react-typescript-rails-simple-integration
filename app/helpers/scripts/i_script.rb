require 'yaml'
# require_all '*/*.rb'
# require_rel '*/*.rb'

module Scripts
  class IScript
    def input_schema
      raise NoMethodError, "implement your supplier: input_schema"
    end

    def get_schema
      res = {}
      schema_files = Dir["#{@this_dir}/schema/*"].select { |f| f =~ /yml|yaml/ }
      schema_files.each do |f|
        file_name = File.basename(f, ".*")
        res[file_name] = YAML.load_file(f)
      end
      res
    end

    # def input_examples
    #   raise NoMethodError, "implement your supplier: input_examples"
    # end

    def input_examples
      res = []
      # example_files = Dir["#{THIS_DIR}/data/*"].collect { |f| {f: YAML.safe_load(f)} }
      example_files = Dir["#{@this_dir}/examples/*"]
      example_files.each do |f|
        file_name = File.basename(f, ".*")
        res << { file_name => YAML.load_file(f) }
      end
      ap res
      res
    end

    def run_script
      raise NoMethodError, "implement your processor: run_script"
    end
  end
end
