class CommentsController < ApplicationController
	
  def new
   @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end  

	def create
   @post = Post.find(params[:post_id])
   @comment = @post.comments.create(comment_params.merge(user: current_user))
   @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @post
    else
      render 'comments/_form'
    end 
  end

  private

  def comment_params
   params.require(:comment).permit(:body, :user_id, :post_id) 	
  end 

end
