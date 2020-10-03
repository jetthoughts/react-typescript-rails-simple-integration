class PreviewsController < ApplicationController
  before_action :set_preview, only: [:show, :edit, :update, :destroy]

  # GET /previews
  # GET /previews.json
  def index
    @previews = Preview.all
  end

  # GET /previews/1
  # GET /previews/1.json
  def show
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
    @preview = Preview.new(preview_params)

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
    respond_to do |format|
      if @preview.update(preview_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_preview
      @preview = Preview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def preview_params
      params.fetch(:preview, {})
    end
end
