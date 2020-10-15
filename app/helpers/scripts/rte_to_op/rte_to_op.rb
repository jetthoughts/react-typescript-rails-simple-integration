
module Scripts
  class RteToOpScript < IScript
    def initialize
      ap "init RteToOpScript"
      @this_dir = File.dirname(__FILE__)
    end
  end
end
