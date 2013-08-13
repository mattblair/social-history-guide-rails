class ThemesController < ApplicationController
  # GET /themes
  # GET /themes.json
  def index
    # for testing, limit to environmentally-defined state:
    @themes = Theme.where("workflow_state_id = #{ENV['WORKFLOW_STATE_TO_DISPLAY']}").order("display_order")
    # limit to published, stories or tidbits > 1, order by display_order
    #@themes = Theme.where("workflow_state_id = 6")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @themes }
    end
  end

  # GET /themes/1
  # GET /themes/1.json
  def show
    @theme = Theme.find(params[:id])
    
    # limit to published, collection 1, order by display_order
    @tidbits = Tidbit.where("theme_id = #{@theme.id}").order("publication_date DESC")
    @stories = Story.where("theme_id = #{@theme.id} and workflow_state_id = #{ENV['WORKFLOW_STATE_TO_DISPLAY']}").order("display_order")
    
    @mappable_stories = Story.where("theme_id = #{@theme.id} and location_valid = 't' and workflow_state_id = #{ENV['WORKFLOW_STATE_TO_DISPLAY']}").order("display_order")
    
    features = []
    
    @mappable_stories.each do |story| 
      features << story.to_geojson.html_safe
    end
    
    @geojson = "{\"type\": \"FeatureCollection\",\"features\": [#{features.join(",")}]}".html_safe
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @theme }
    end
  end

  # GET /themes/new
  # GET /themes/new.json
  def new
    @theme = Theme.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @theme }
    end
  end

  # GET /themes/1/edit
  def edit
    @theme = Theme.find(params[:id])
  end

  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(params[:theme])

    respond_to do |format|
      if @theme.save
        format.html { redirect_to @theme, notice: 'Theme was successfully created.' }
        format.json { render json: @theme, status: :created, location: @theme }
      else
        format.html { render action: "new" }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /themes/1
  # PUT /themes/1.json
  def update
    @theme = Theme.find(params[:id])

    respond_to do |format|
      if @theme.update_attributes(params[:theme])
        format.html { redirect_to @theme, notice: 'Theme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy

    respond_to do |format|
      format.html { redirect_to themes_url }
      format.json { head :no_content }
    end
  end
  
  def needphoto
    @theme = Theme.find(params[:id])
    
    # limit to published, collection 1, order by display_order
    @stories = Story.where("theme_id = #{@theme.id} and workflow_state_id = #{ENV['WORKFLOW_STATE_TO_DISPLAY']}").order("display_order")
    
    respond_to do |format|
      format.html
    end
  end
end
