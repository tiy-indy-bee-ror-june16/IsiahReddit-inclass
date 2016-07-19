class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @num = 1
    kaminari_links
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(username: @user.username), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(username: @user.username), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by username: params[:username]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :description, :email, :password)
    end

    def all_user_links
      user_generated_links
      user_liked_links
      user_disliked_links
      user_clicked_links
    end
#why not working???
    def kaminari_links
      @user_links_posts = []
      @user_links_posts += @user.links
      @user_links_posts += @user.downvoted_links
      @user_links_posts += @user.clicked_links
      @user_links_posts += @user.upvoted_links
      @user_links_posts = Kaminari.paginate_array(@user_links_posts).page(params[:page]).per(10)
      #@user_links_posts is nil. Why??
    end

    def user_generated_links
      @user_links = @user.links
    end

    def user_liked_links
      @user.upvoted_links
    end

    def user_disliked_links
      @user.downvoted_links
    end

    def user_clicked_links
      @user.clicked_links
    end

end
