require 'amazing_print'

module WikiGrapher
  def wiki
    puts wiki_params
    ap wiki_params

    # ap params

    # redirect_to root_path
  end

  private
  def wiki_params
    params.require(:wikiinput).permit(:sections, :template, :filename, :config)
  end
end
