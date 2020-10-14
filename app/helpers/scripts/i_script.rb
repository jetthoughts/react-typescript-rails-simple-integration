require 'yaml'
# require_all '*/*.rb'
# require_rel '*/*.rb'

module Scripts
  class IScript
    def input_schema
      raise NoMethodError, "implement your supplier: input_schema"
    end

    def input_examples
      raise NoMethodError, "implement your supplier: input_examples"
    end

    def run_script
      raise NoMethodError, "implement your processor: run_script"
    end
  end
end
