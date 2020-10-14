require 'amazing_print'
require_relative '../helpers/scripts/script_crawler'

# SCRIPTS_MAP = generate_script_procs_map

class ScriptController < ApplicationController
  include ScriptCrawler
  # ap SCRIPTS

  def index
  end

  def input_fetch
    # request_input = request_input_params
    request_input = request_params
    ap request_input

    script = find_script(request_input['script'])
    # params = find_script(request_input['params'])

    input = {}
    input['input_schema'] = script.input_schema
    input['examples'] = []

    # ap "input_fetch: #{ap input}"
    # ap "input_fetch: #{input}"
    #
    # ap "input_fetch:"
    # ap input

    respond_to do |format|
      format.json { render json: input.to_json }
    end
  end

  def output_fetch
    request_input = request_params
    ap request_input

    # script = find_script(request_input['script'])
    # params = find_script(request_input['params'])

    output = {}
    output['input'] = request_input
    output['output'] = script.run(params)

    ap "output_fetch: #{output}"

    respond_to do |format|
      format.json { render json: output.to_json }
    end
  end

  private
  def find_script(script_key)
    SCRIPTS_MAP[script_key] || raise(ArgumentError,"unknown script: `#{script_key}`")
  end

  def read_yml(filename, dir)
    File.read("#{dir}/data/#{filename}.yml")
  end

  def request_input_params
    params.require(:id)
  end

  def request_params
    params.require(:input).permit(:script, :params, :id)
  end
end
