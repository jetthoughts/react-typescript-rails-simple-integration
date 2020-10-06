require 'amazing_print'

module WikiGrapher
  # before_action :set_result, only: [:wiki]
  def index
    puts "load WikiGrapher.index"
    # @sample = nil
    # @result = {kod: 'sar'}
    # @result = "{kod: 'sar'}"
    # @result = nil
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
    wikiinput['filename'] = "defaultFileName" if wikiinput['filename'].strip.empty?
    @result = wikiinput.to_json
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
        format.json { render json: @result }
      end
    end
    # res
    # render 'welcome/_see', layout: false
    # ap params

    # redirect_to root_path
  end

  private

  def load_sample_presets
    @sample = {}
    @sample['sections'] = "
kod

    sar"
  end

  def wiki_params
    # params.require(:wikiinput).permit(:sections, :template, :filename, :config)
    # params.require(:sections, :template, :filename, :config)
    res = {}
    # puts params
    [:sections, :template, :filename, :config].each { |k| res[k.to_s] = params[k] }
    # puts res
    res
  end
end
