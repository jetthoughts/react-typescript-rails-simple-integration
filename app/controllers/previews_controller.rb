require_relative 'concerns/textedit/json_from_console'

class PreviewsController < ApplicationController
  before_action :set_preview, only: [:show, :edit, :update, :destroy]
  include JsonFromConsole

  # GET /previews
  # GET /previews.json
  def index
    @previews = Preview.all
  end

  # GET /previews/1
  # GET /previews/1.json
  def show
  end

  def res
    # render "previews/_see", locals: { prev: @preview}, layout: false
    render 'previews/_see', locals: { prev: @preview}, layout: false
  end

  # GET /previews/new
  def new
    @preview = Preview.new
  end

  # GET /previews/1/edit
  def edit
  end

  # POST /previews
  # POST /previews.json
  def create
    # @preview = Preview.new(preview_params)

    @preview = Preview.new(make_preview_hsh)

    respond_to do |format|
      if @preview.save
        format.html { redirect_to @preview, notice: 'Preview was successfully created.' }
        format.json { render :show, status: :created, location: @preview }
      else
        format.html { render :new }
        format.json { render json: @preview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /previews/1
  # PATCH/PUT /previews/1.json
  def update
    # set_preview
    # @prev = @preview
    @prev = set_preview
    respond_to do |format|
      if @preview.update(make_preview_hsh)
        format.html { redirect_to @preview, notice: 'Preview was successfully updated.' }
        format.json { render :show, status: :ok, location: @preview }
      else
        format.html { render :edit }
        format.json { render json: @preview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /previews/1
  # DELETE /previews/1.json
  def destroy
    @preview.destroy
    respond_to do |format|
      format.html { redirect_to previews_url, notice: 'Preview was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def make_preview_hsh
    conv = json_convert
    conv_hsh = JSON.parse(conv.to_json)
  end

  # Use callbacks to share common setup or constraints between actions.
    def set_preview
      @preview = Preview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def preview_params
      # params.fetch(:preview, {})
      params.fetch(:preview, :str_input)
    end
end
