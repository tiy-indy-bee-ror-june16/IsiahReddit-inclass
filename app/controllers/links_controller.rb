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
    if session[:user_id]
      Vote.create(value:1.0, link_id:@link.id, user_id:session[:user_id])
      redirect_to :back
    else
      redirect_to login_path
      flash.notice = "Please login or create an account in order to vote"
    end
  end

  def down_vote
    if session[:user_id]
      Vote.create(value: -1.0, link_id:@link.id, user_id:session[:user_id])
      redirect_to :back
    else
      redirect_to login_path
      flash.notice = "Please login or create an account in order to vote"
    end
  end

  def go
    if session[:user_id]
      Vote.create(value: 0.2, link_id:@link.id, user_id:session[:user_id])
    else
      Vote.create(value: 0.2, link_id:@link.id, user_id: nil)
    end
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
      redirect_to root_path
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

  def search
    @num = 1
    @searched_links = Link.searched_links(params[:search_term])
    @searched_users = User.searched_users(params[:search_term])
    @searched_subreddits = Subreddit.searched_subreddits(params[:search_term])
    @searched_users += @searched_subreddits
    @searched_users += @searched_links
    #why does += not work instead of <<??
    # @searched_links += User.searched_users(params[:search_term])
    # @searched_links += Subreddit.searched_subreddits(params[:search_term])
    if @searched_links[0]
      @search_message = "Here are the users, subreddits, and posts that match your search terms:"
    else
      @search_message = "I'm sorry, we were not able to find any matches for your search term"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:address, :title, :summary, :vote_score, :subreddit_id, :user_id, :picture)
    end

    def add_http
      unless @link.address.downcase.start_with?("http")
        @link.address = @link.address.insert(0, "http://")
      end
    end
end
