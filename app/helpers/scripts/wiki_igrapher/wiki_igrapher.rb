require 'yaml'

module Scripts
  module WikiIgrapher
    # include IScript
    # settings -------
    # todo: make optional?
    DEFAULT_W = 550
    DEFAULT_H = 300
    DEFAULT_LAYOUT = 'default'.freeze

    # code --------
    LAYOUT_PRESETS = {
        'default' => ['60D1D', '4D1H', '5H5m'],
        'old_default' => ['30D1D', '7D1H', '8H5m'],
        'long' => ['60D1D', '30D1D', '7D1H', '4D1H', '5H5m', '3H1m'],
        # 'long2' => ['60D1D', '7D1H', '4D1H', '5H5m', '3H1m'],
    }.freeze

    # HTML_BREAK = "<br>"
    HTML_BREAK = "\n".freeze
    SECTIONS = 'sections'.freeze
    TEMPLATES = 'template'.freeze
    DEPTH = 'depth'.freeze
    LAYOUT = 'layout'.freeze

    #@param Hash JSON InputSchema
    def input_schema
      # {
      #     "title": "Person",
      #     "type": "object",
      #     "required": [
      #         "name",
      #         "age",
      #         "date",
      #         "favorite_color",
      #         "gender",
      #         "location",
      #         "pets"
      #     ],
      #     "properties": {
      #         "name": {
      #             "type": "string",
      #             "description": "First and Last name",
      #             "minLength": 4,
      #             "default": "Jeremy Dorn"
      #         },
      #         "age": {
      #             "type": "integer",
      #             "default": 25,
      #             "minimum": 18,
      #             "maximum": 99
      #         },
      #         "favorite_color": {
      #             "type": "string",
      #             "format": "color",
      #             "title": "favorite color",
      #             "default": "#ffa500"
      #         },
      #         "gender": {
      #             "type": "string",
      #             "enum": [
      #                 "male",
      #                 "female",
      #                 "other"
      #             ]
      #         },
      #         "date": {
      #             "type": "string",
      #             "format": "date",
      #             "options": {
      #                 "flatpickr": {}
      #             }
      #         },
      #         "location": {
      #             "type": "object",
      #             "title": "Location",
      #             "properties": {
      #                 "city": {
      #                     "type": "string",
      #                     "default": "San Francisco"
      #                 },
      #                 "state": {
      #                     "type": "string",
      #                     "default": "CA"
      #                 },
      #                 "citystate": {
      #                     "type": "string",
      #                     "description": "This is generated automatically from the previous two fields",
      #                     "template": "{{city}}, {{state}}",
      #                     "watch": {
      #                         "city": "location.city",
      #                         "state": "location.state"
      #                     }
      #                 }
      #             }
      #         },
      #         "pets": {
      #             "type": "array",
      #             "format": "table",
      #             "title": "Pets",
      #             "uniqueItems": true,
      #             "items": {
      #                 "type": "object",
      #                 "title": "Pet",
      #                 "properties": {
      #                     "type": {
      #                         "type": "string",
      #                         "enum": [
      #                             "cat",
      #                             "dog",
      #                             "bird",
      #                             "reptile",
      #                             "other"
      #                         ],
      #                         "default": "dog"
      #                     },
      #                     "name": {
      #                         "type": "string"
      #                     }
      #                 }
      #             },
      #             "default": [
      #                 {
      #                     "type": "dog",
      #                     "name": "Walter"
      #                 }
      #             ]
      #         }
      #     }
      # }

      {
          "title": "WikiIGrapher",
          "type": "object",
          "required": [
              SECTIONS,
              # TEMPLATES,
              DEPTH,
              LAYOUT,
          ],
          "properties": {
              SECTIONS => {
                  "type": "string",
              },
              TEMPLATES => {
                  "type": "string",
              },
              DEPTH => {
                  "type": "integer",
                  "default": 1,
                  "minimum": 0,
              },
              LAYOUT => {
                  "type": "string",
                  "enum": LAYOUT_PRESETS.keys
              },
              "default": [
                  {
                      # DEPTH: 1,
                      LAYOUT: 'default'
                  }
              ]
          }
      }.to_json

      # {
      #     SECTIONS: SECTIONS,
      #     TEMPLATES: TEMPLATES,
      #     DEPTH: DEPTH,
      #     LAYOUT: LAYOUT,
      # }
    end

    THIS_DIR = File.dirname(__FILE__)
    def input_examples
      res = []
      # example_files = Dir["#{THIS_DIR}/data/*"].collect { |f| {f: YAML.safe_load(f)} }
      example_files = Dir["#{THIS_DIR}/data/*"]
      example_files.each do |f|
        file_name = File.basename(f, ".*")
        res << {file_name => YAML.load_file(f)}
      end
      ap res
      res
    end

    #@param Hash InputSchema
    def run_script(input_params)
      @wiki = []
      sections = input_params[SECTIONS]
      template = optional_handle(input_params[TEMPLATES])
      depth = input_params[DEPTH].to_i
      @layout = input_params[LAYOUT] # todo: non stateful?

      # make_comment sections, SECTIONS
      # if template.nil?
      #   make_comment template, TEMPLATES
      # end
      # make_comment depth, DEPTH
      # make_comment input_params.to_yaml, 'input_params'
      make_comment pretty_yml(input_params.to_yaml), 'input_params'
      # make_comment input_params, 'input_params'
      # @wiki << spacer(3)
      make_wiki YAML.load(sections), depth, (template ? YAML.load(template) : nil)
      @wiki.join HTML_BREAK
    end

    def pretty_yml yml
      yml.gsub(/\\r\\n/, "\n")
    end

    protected
    def optional_handle(item)
      return nil if item.nil? || item.strip.empty?

      item
    end

    TIME_UNIT_MAP = {
        'D' => 'Day',
        'H' => 'Hour',
    }.freeze

    PERIOD_MAP = {
        '1W' => 'OneWeek',
        '1D' => 'OneDay',
        '1H' => 'OneHour',
        '5m' => 'FiveMinute',
        '1m' => 'OneMinute',
        '1s' => 'OneSecond', #? cloud watch does it, test..
    }.freeze

    # &StartTime1=-P7D&
    # &StartTime1=-PT8H&
    def make_time(time, unit)
      time_unit = TIME_UNIT_MAP[unit]
      time_prefix = time_unit =~ /H/ ? 'PT' : 'P'
      "#{time_prefix}#{time}#{unit}"
    end

    # &Period1=OneDay&
    # &Period1=OneHour&
    # &Period1=FiveMinute&
    def make_period(period)
      PERIOD_MAP[period]
    end

    # ['60D1D', '4D1H', '5H5m']
    # |=60 Day [1 day]|=4 Day [1 hr]|=5 Hour [5 min]
    def make_title(time, unit, period)
      time_unit = TIME_UNIT_MAP[unit]
      "#{time} #{time_unit} [#{make_period(period)}]"
    end

    def time_period_parse(time_period)
      time, unit, period = time_period.match(/(\d+)(\w)(.*)/).captures
      [make_time(time, unit), make_period(period), make_title(time, unit, period)]
    end

    def fix_time_period graph, time, period
      graph
          .gsub(/&StartTime1=-([\w\d]+)&/, "&StartTime1=-#{time}&") #time
          .gsub(/&Period1=(\w+)&/, "&Period1=#{period}&") #period
    end

    #|width=550|height=300
    def fix_sizes str, w = 550, h = 300
      str.gsub(/\|width=(\d+)\|height=(\d+)/, "|width=#{w}|height=#{h}")
    end

    def print_wikitable(graph, layout = @layout)
      cols = LAYOUT_PRESETS[layout]
      title_cols = []
      graph_cols = []
      cols.each do |time_period|
        time, period, pretty_title = time_period_parse time_period
        # "time #{time}, period #{period}"
        # add title
        title_cols << pretty_title
        # add graph
        size_fixed_graph = fix_sizes graph, DEFAULT_W, DEFAULT_H
        graph_cols << fix_time_period(size_fixed_graph, time, period)
      end

      # cols.print_title
      title_sep = '|='
      @wiki << "#{title_sep}#{title_cols.join(title_sep)}"

      # cols.print_graphs
      @wiki << '|'
      graph_sep = " |#{HTML_BREAK}"
      @wiki << graph_cols.join(graph_sep)
    end

    # will fail if value does not contain {{igraph ... }}
    def quick_validate_and_clean(graph)
      return graph if graph.nil?

      # graph.match(/(\{\{igraph.*\}\})/)[0]
      match = graph.match(/^(\{\{igraph.*\}\})$/)
      match
    end

    def make_wiki_title(title_str, level = 1)
      tag = '=' * level
      "#{tag}#{title_str}#{tag}"
    end

    def quick_and_dirty_sub(sub_str, template_map)
      template_node = {}
      template_map.each { |title, graph| template_node[title] = graph.gsub(/DEFAULT_SIMPLE_SUB/, sub_str) }
      template_node
    end

    def process_str(obj, level, template_map)
      if quick_validate_and_clean obj
        print_wikitable obj
      elsif template_map
        template_node = quick_and_dirty_sub obj, template_map
        make_wiki template_node, level + 1
      else
        raise 'didnt find a well-formed igraph.. so was expecting a template map!?'
      end
    end

    def make_wiki(node, level = 1, template_map = nil)
      # obj == sections_or_graph_or_template_subs
      # @wiki << spacer(2)
      node.each do |title, obj|
        type = obj.class.to_s
        @wiki << make_wiki_title(title, level)
        @wiki << spacer(1)
        if type == "Hash"
          make_wiki obj, level + 1, template_map
        elsif type == "String"
          process_str obj, level, template_map
        else
          raise 'yml not right!'
        end
        @wiki << spacer(1)
      end
    end

    def make_comment(yml_str, title)
      @wiki << '{{comment}}'
      @wiki << (surround_spacer(1) { title.capitalize }) if title
      @wiki << '=' * title.size if title
      # @wiki << spacer
      @wiki << yml_str
      @wiki << '{{/comment}}'
      @wiki << spacer(2)
    end

    def spacer(n = 1)
      # "\n" * n
      HTML_BREAK * n
      # "#{HTML_BREAK}\n" * n
    end

    def surround_spacer(n = 1)
      spacer(n) + yield + spacer(n)
    end

    def prepare_yml(filename, dir = '.')
      yml_str = File.read("#{dir}/data/#{filename}.yml")
      # print_comment yml_str, filename
      # YAML.load(yml_str)
    end
  end

  class WikiIgrapherScript < IScript
    include WikiIgrapher

    def initialize
      ap "init WikiIgrapherScript"
    end
  end
end
