class TidbitsController < ApplicationController
  # GET /tidbits
  # GET /tidbits.json
  def index
    @tidbits = Tidbit.order("publication_date DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tidbits }
    end
  end

  # GET /tidbits/1
  # GET /tidbits/1.json
  def show
    @tidbit = Tidbit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tidbit }
    end
  end

  # GET /tidbits/new
  # GET /tidbits/new.json
  def new
    @tidbit = Tidbit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tidbit }
    end
  end

  # GET /tidbits/1/edit
  def edit
    @tidbit = Tidbit.find(params[:id])
  end

  # POST /tidbits
  # POST /tidbits.json
  def create
    @tidbit = Tidbit.new(params[:tidbit])

    respond_to do |format|
      if @tidbit.save
        format.html { redirect_to @tidbit, notice: 'Tidbit was successfully created.' }
        format.json { render json: @tidbit, status: :created, location: @tidbit }
      else
        format.html { render action: "new" }
        format.json { render json: @tidbit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tidbits/1
  # PUT /tidbits/1.json
  def update
    @tidbit = Tidbit.find(params[:id])

    respond_to do |format|
      if @tidbit.update_attributes(params[:tidbit])
        format.html { redirect_to @tidbit, notice: 'Tidbit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tidbit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tidbits/1
  # DELETE /tidbits/1.json
  def destroy
    @tidbit = Tidbit.find(params[:id])
    @tidbit.destroy

    respond_to do |format|
      format.html { redirect_to tidbits_url }
      format.json { head :no_content }
    end
  end
end
