require_relative 'concerns/textedit/wiki_grapher'
require_relative 'concerns/textedit/json_from_console'

class TexteditController < ApplicationController
  include WikiGrapher
  include JsonFromConsole
end
