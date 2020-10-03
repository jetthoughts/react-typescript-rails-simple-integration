require 'json'
#paste this script to: jc.rb
require 'amazing_print'
require 'active_support/all'
require 'active_model'

# class BaseJsonModel
#   include ActiveModel::Serializers::JSON
#
#   def attributes=(hash)
#     hash.each do |key, value|
#       send("#{key}=", value)
#     end
#   end
#
#   def attributes
#     instance_values
#   end
# end
#
# class Product < BaseJsonModel
#   attr_accessor :id, :title
# end
#
# asin = Product.new
#
# puts asin.from_json(json)
#
# puts asin

module JsonFromConsole
  def index
    redirect_to '/textedit/json_convert'
  end

  def json
    puts json_params
    ap json_params
    # conv = JSON.parse(json, object_class: OpenStruct)
    conv = JsonConverter.new
    conv.from_json json_params
    puts conv
    # ap params

    # redirect_to root_path
  end

  private
  def json_params
    params.require(:jsoninput).permit(:str_input)
  end
end

class JsonConverter
  include ActiveModel::Serializers::JSON

  attr_accessor :str_input, :json_output

  def initialize
    super
  end

  #@return json_output
  def convert
    if str_input.nil?
      usage[]
    else
      puts "\nInput:\n\n#{str_input}\n"
      #todo: handle exceptions
      str = str_input.match(/AsyncEventTrigger\((.*)\)/).to_a[1]
      req = str.scan(/(\w+)=(.*?)[,)] /).map { |k, v| "#{k.dump}: #{v.dump}" }.join ', '
      json_output = JSON.parse("{#{req}}")
      puts "\nOutput:\n\n#{JSON.pretty_generate(json_output)}\n\n"
    end
    json_output
  end
end
