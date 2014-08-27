class PresentationsController < ApplicationController
  before_action :set_presentation, only: [:show, :edit, :update, :destroy]

  # GET /presentations
  # GET /presentations.json
  def index
    @presentations = Presentation.all
  end

  # GET /presentations/1
  # GET /presentations/1.json
  def show
  end

  # GET /presentations/new
  def new
    @presentation = Presentation.new(event_id: params[:event_id])
  end

  # GET /presentations/1/edit
  def edit
  end

  # POST /presentations
  # POST /presentations.json
  def create
    @presentation = Presentation.new(presentation_params)

    respond_to do |format|
      if @presentation.save
        format.html { redirect_to event_path(@presentation.event), notice: 'Presentation was successfully created.' }
        format.json { render :show, status: :created, location: @presentation }
      else
        format.html { render :new }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presentations/1
  # PATCH/PUT /presentations/1.json
  def update
    respond_to do |format|
      if @presentation.update(presentation_params)
        format.html { redirect_to event_path(@presentation.event), notice: 'Presentation was successfully updated.' }
        format.json { render :show, status: :ok, location: @presentation }
      else
        format.html { render :edit }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presentations/1
  # DELETE /presentations/1.json
  def destroy
    event = @presentation.event
    @presentation.destroy
    respond_to do |format|
      format.html { redirect_to event_path(event), notice: 'Presentation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_presentation
    @presentation = Presentation.find(params[:id])
  end

  def presentation_params
    params.require(:presentation).permit(:title, :description, :video, :video_cache, :event_id, :category_id)
  end
end
