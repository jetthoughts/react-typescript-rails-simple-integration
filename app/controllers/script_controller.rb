require 'amazing_print'
require '../helpers/script_crawler'

class ScriptController < ApplicationController
  include ScriptCrawler
  SCRIPTS = generate_script_procs

  def index
  end

  def input_fetch
    request_input = request_params
    ap request_input


    input = {}
    input['input_schema'] = request_input
    input['examples'] =

    ap "input_fetch: #{input}"

    respond_to do |format|
      format.json { render json: input.to_json }
    end
  end

  def output_fetch
    request_input = request_params
    ap request_input

    script = find_script(request_input['script'])
    params = find_script(request_input['params'])

    output = {}
    output['input'] = request_input
    output['output'] = script.process_data(params)

    ap "output_fetch: #{output}"

    respond_to do |format|
      format.json { render json: output.to_json }
    end
  end

  private

  def read_yml(filename, dir)
    File.read("#{dir}/data/#{filename}.yml")
  end

  def request_params
    params.require(:input).permit(:script, :params)
  end
end
