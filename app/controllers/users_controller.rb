class UsersController < ApplicationController

def index
 @users = User.all
end

def show

end

private

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_url, notice: "Please sign in."
  end
end

def post_params
  params.require(:post).permit(:title, :body)
end

end
