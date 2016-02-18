class PostsController < ApplicationController
  before_filter :correct_user, only: [:destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  

  # GET /posts
  # GET /posts.json
  def index
   #if params[:search]
    #@posts = Post.all.search(params[:search])
   #else
    @posts = Post.all.search(params[:search]).paginate(page: params[:page], :per_page => 6).order('created_at DESC')
   #end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find(params[:id])
    @post = Post.find(params[:id])
    @comments = @post.comments.order('created_at DESC')
    
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id]) 
      if current_user.id == @post.user.id
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def comment
    @comments = @user.posts.comments.build(params_comment)
    render show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
    
    def correct_user
    @post = current_user.posts.find_by(params[:id])
    redirect_to root_path if @post.nil?
    end
end
