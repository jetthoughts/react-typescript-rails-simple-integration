require 'amazing_print'

require_relative '../../../../app/helpers/wiki_igrapher_helper'

module WikiGrapher
  include WikiIgrapherHelper
  # before_action :set_result, only: [:wiki]
  def index
    puts "load WikiGrapher.index"
    load_sample_presets
  end

  def res
    # render 'welcome/_see', layout: false
    render 'welcome', layout: false
  end

  def wiki
    wikiinput = wiki_params
    puts wikiinput
    ap wikiinput
    # wikiinput['filename'] = "defaultFileName" if wikiinput['filename'].strip.empty?
    wikiinput['depth'] = 0 if wikiinput['depth'].nil?
    @result = {}
    # @result['input'] = JSON.pretty_generate(wikiinput)
    # @result['input'] = JSON.pretty_generate(wikiinput.to_json).to_s
    @result['input'] = wikiinput
    @result['output'] = process_data(wikiinput)

    puts "res: #{@result}"
    # @result

    # respond_to :html, :json
    # render json: @result, status: :ok
    #
    # redirect_to root_path # clears forms and reloads scopes
    # render root_path # same as above
    # render 'welcome', layout: false # no results
    # render 'welcome', result: @result, layout: false
    # render 'welcome/_see', result: @result, layout: false

    # respond_to do |format|
    #   unless @result.nil?
    #     # format.json { render json: @result, status: :ok }
    #     format.js { render json: @result, status: :ok }
    #     # format.html { render 'welcome/_see', result: @result, layout: false }
    #     # format.html { render '../welcome/index', result: @result, layout: false }
    #     #
    #     # load_sample_presets
    #     # format.html { render 'welcome/index', result: @result, layout: false }
    #     #
    #     # format.html { render 'welcome', result: @result, layout: false }
    #   end
    # end

    #api return
    # render json: @result, status: :ok

    # @result # not in response

    respond_to do |format|
      unless @result.nil?
        # format.json { render json: @result, status: :ok }
        format.json { render json: @result.to_json }
      end
    end
    # res
    # render 'welcome/_see', layout: false
    # ap params

    # redirect_to root_path
  end

  private

  def read_yml(filename,dir)
    File.read("#{dir}/data/#{filename}.yml")
  end

  def load_sample_presets
    @sample = {}
    sections = read_yml 'sections', './spec/helpers'
    template = read_yml 'template', './spec/helpers'
    @sample['sections'] = sections
    @sample['template'] = template

    @options = LAYOUT_PRESETS
  end

  def wiki_params
    # params.require(:wikiinput).permit(:sections, :template, :filename, :config)
    # params.require(:sections, :template, :filename, :config)
    res = {}
    # puts params
    [:sections, :template, :depth, :layout].each { |k| res[k.to_s] = params[k] }
    # puts res
    res
  end
end
