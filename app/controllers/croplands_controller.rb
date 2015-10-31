class CroplandsController < ApplicationController
  before_action :set_cropland, only: [:show, :edit, :update, :destroy]

  # GET /croplands
  # GET /croplands.json
  def index
    @croplands = Cropland.all
  end

  # GET /croplands/1
  # GET /croplands/1.json
  def show
  end

  # GET /croplands/new
  def new
    @cropland = Cropland.new
  end

  # GET /croplands/1/edit
  def edit
  end

  # POST /croplands
  # POST /croplands.json
  def create
    @cropland = Cropland.new(cropland_params)

    respond_to do |format|
      if @cropland.save
        format.html { redirect_to @cropland, notice: 'Cropland was successfully created.' }
        format.json { render :show, status: :created, location: @cropland }
      else
        format.html { render :new }
        format.json { render json: @cropland.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /croplands/1
  # PATCH/PUT /croplands/1.json
  def update
    respond_to do |format|
      if @cropland.update(cropland_params)
        format.html { redirect_to @cropland, notice: 'Cropland was successfully updated.' }
        format.json { render :show, status: :ok, location: @cropland }
      else
        format.html { render :edit }
        format.json { render json: @cropland.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /croplands/1
  # DELETE /croplands/1.json
  def destroy
    @cropland.destroy
    respond_to do |format|
      format.html { redirect_to croplands_url, notice: 'Cropland was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cropland
      @cropland = Cropland.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cropland_params
      params.require(:cropland).permit(:user_id, :land_area, :area_unit, :land_production, :land_output, :output_unit, :output_cycle, :latest_seeding_date, :product_id)
    end
end
