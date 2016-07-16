class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy, :up_vote, :down_vote, :go]
  #debugging heroku heroku log -t
  # GET /links
  # GET /links.json
  def index
    @links = Link.order(vote_score: :desc).page(params[:page]).per(10)
    @num = 1 + ((@links.current_page - 1) * 10)
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  def up_vote
    @link.increment!(:vote_score)
    redirect_to :back
  end

  def down_vote
    @link.increment!(:vote_score, -1)
    redirect_to :back
  end

  def go
    @link.increment!(:vote_score)
    redirect_to @link.address
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    add_http
    if Link.find_by address: @link.address.downcase
      new_link = Link.find_by address: @link.address
      redirect_to go_path(new_link)
    else
      @link.vote_score = 0
      respond_to do |format|
        if @link.save
          format.html { redirect_to @link, notice: 'Link was successfully created.' }
          format.json { render :show, status: :created, location: @link }
        else
          format.html { render :new }
          format.json { render json: @link.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:address, :title, :summary, :vote_score, :subreddit_id, :user_id)
    end

    def add_http
      unless @link.address.downcase.start_with?("http")
        @link.address = @link.address.insert(0, "http://")
      end
    end
end
