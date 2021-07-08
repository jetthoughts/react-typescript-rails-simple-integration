# $LOAD_PATH << File.expand_path("#{File.dirname(__FILE__)}")
require 'logging'

# Logger params
Logging.init :trace, :debug, :info, :warn, :error, :fatal

# Custom colour set
Logging.color_scheme('my_bright',
                     :levels => {
                         :trace => :white,
                         :debug => :blue,
                         :info => :green,
                         :warn => :yellow,
                         :error => :red,
                         :fatal => [:black, :on_red]
                     },
                     :date => :blue,
                     :logger => :cyan,
                     :message => :white
)

# https://www.rubydoc.info/gems/logging/Logging/Layouts/Pattern/FormatMethodBuilder

LOG_PATTERN_SIMPLE = "[%d] %-5l %m\n"
LOG_PATTERN_WITH_CLASS = "[%d] %-5l %c: %m\n"
LOG_PATTERN_WITH_METHODS = "[%d] %-5l %c: %M: %m\n" # need to get this to work
LOG_PATTERN_WITH_ALL = "[%d] %-5l %c: %M: %h: %p: %r: %T: %t: %F: %L: %M: %x\n"


TIMESTAMP_PATTERN = "%Y-%m-%d %H:%M:%S.%L"
LOG_TIME_TODAY = Time.now.strftime("%Y-%m-%d")
LOG_TIME_NOW = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

LOG_LOC = "./logs"
LOG_FILE = "log_#{LOG_TIME_TODAY}.log"
LOG_FILE_PATH = File.join(LOG_LOC, LOG_FILE)

LOG_STDOUT = 'stdout'

Dir.mkdir(LOG_LOC) unless Dir.exists? LOG_LOC

module LoggerSetup
  def self.reset_appender_log_levels stdout_level = :info, file_level = :trace

# Stdout appender
    Logging.appenders.stdout(LOG_STDOUT,
                             # level: :info, # a different log level to your file appender
                             level: stdout_level, # a different log level to your file appender
                             layout: Logging.layouts.pattern(
                                 pattern: LOG_PATTERN_WITH_CLASS,
                                 color_scheme: 'my_bright', # best not to use color_schemes on file loggers
                                 date_pattern: TIMESTAMP_PATTERN))

# File appender
    Logging.appenders.file(LOG_FILE_PATH,
                           # level: :debug, # or your custom lowest level init-ed
                           level: file_level, # or your custom lowest level init-ed
                           layout: Logging.layouts.pattern(
                               pattern: LOG_PATTERN_WITH_CLASS,
                               # color_scheme: 'my_bright', # best not to use color_schemes on file loggers
                               date_pattern: TIMESTAMP_PATTERN),
                           # truncate: true, # if you want to clear old log information
                           # age:      5 * 60, # feel free to play around with these
                           roll_by: :date # for rolling logs if you want to change files periodically
    )

  end
end

# to restore defaults, run
# LoggerSetup.reset_appender_log_levels # stdout_level = :info, file_level = :debug
LoggerSetup.reset_appender_log_levels :error, :trace


# sample logger setup module
module LoggerSetup
  attr_reader :log

  def init_logger(level = nil)
    @log = Logging.logger[self]
    @log.level = level || :debug # your lowest level
    @log.add_appenders(
        LOG_STDOUT,
        LOG_FILE_PATH
    )
    @log
  end
end

if __FILE__ == $0

  class UsageExample
    include LoggerSetup

    def initialize
      super
      init_logger :debug
    end

    def sample_call
      @log.debug "hello"
    end
  end

  use = UsageExample.new
  use.sample_call

end
