require 'amazing_print'
require_relative '../helpers/scripts/script_crawler'

class ScriptController < ApplicationController
  include ScriptCrawler

  def index
    respond_to do |format|
      format.html { render 'script/index'}
      format.json { render json: {scripts: SCRIPTS_MAP.keys}.to_json }
    end
  end

  def input_fetch
    # request_input = request_input_params
    request_input = params[:id]
    # request_input = request_params
    ap request_input

    # script = find_script(request_input['script'])
    script = find_script(request_input)

    input = {}
    input['input_schema'] = script.input_schema
    input['examples'] = script.input_examples

    respond_to do |format|
      format.json { render json: input.to_json }
    end
  end

  def output_fetch
    request_input = request_params
    ap request_input

    script = find_script(request_input['script'])
    params = JSON.parse(request_input['input_params']) #todo: unsafe? errors?

    output = {}
    output['input'] = request_input
    output['output'] = script.run_script(params) #todo: print errors?

    ap "output_fetch: #{output}"

    respond_to do |format|
      format.json { render json: output.to_json }
    end
  end

  private
  def find_script(script_key)
    SCRIPTS_MAP[script_key] || raise(ArgumentError, "unknown QuickScript: `#{script_key.inspect}`")
  end

  def read_yml(filename, dir)
    File.read("#{dir}/data/#{filename}.yml")
  end

  def request_input_params
    params.require(:id)
  end

  def request_params
    # params.require(:input).permit(:input_params, :script, :id)
    params.require(:input).permit(:input_params, :script)
  end
end
