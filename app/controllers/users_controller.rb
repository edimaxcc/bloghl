class UsersController < ApplicationController

def index
 @users = User.all
  if current_user
  @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 6)
  #posts from following
  @user_id = current_user.following.map{|user| user.id}
  @posts =  Post.where(user_id: @user_id)
  @search_following_posts = @posts.search(params[:search]).paginate(page: params[:page], :per_page => 6).order('created_at DESC') 
  else
  @posts = Post.all.search(params[:search]).paginate(page: params[:page], :per_page => 6).order('created_at DESC')
  end
  
end

def following
  @title = "Following"
  @user  = User.find(params[:id])
  @users = @user.following.paginate(page: params[:page])
  render 'show_follow'
end

def followers
  @title = "Followers"
  @user  = User.find(params[:id])
  @users = @user.followers.paginate(page: params[:page])
  
end

def welcome
  @title = "Wellcome This page is a demonstration"
  @user = User.all
  render 'index'
end

def show
  @users = User.all.paginate(page: params[:page], :per_page => 6).order('created_at DESC')
  @user = User.find(params[:id])
  @user_posts = @user.posts.paginate(page: params[:page], :per_page => 6).order('created_at DESC')
  @users_following = @user.following.paginate(page: params[:page], :per_page => 6).order('created_at DESC')
  @users_followers = @user.followers.paginate(page: params[:page], :per_page => 6).order('created_at DESC')
  @feed_items = @user.feed.paginate(page: params[:page], :per_page => 6)
  @user_id = @user.following.map{|user| user.id}
  @posts =  Post.where(user_id: @user_id).paginate(page: params[:page], :per_page => 6).order('created_at DESC') 
  @search_following_posts = @posts.search(params[:search]).paginate(page: params[:page], :per_page => 6).order('created_at DESC')
end

def update
    if params[:user][:password].mb_chars.length >= 8 && params[:user][:password_confirmation].mb_chars.length >= 8
      @user = User.find(current_user.id)
      if @user.valid_password?(params[:user][:current_password]) && params[:user][:password] == params[:user][:password_confirmation]
        @user.password = params[:user][:password]
        if params[:user][:password].match(/(?=.*[A-Z])(?=.*[0-9])/)
          @user.save(validate: false)
          # Sign in the user by passing validation in case their password changed
          sign_in @user, :bypass => true
          flash[:notice] = "Senha atualizada com sucesso!"
          redirect_to @user
        else
          flash[:notice] = "Precisa incluir ao menos uma letra maiúscula e um número."
        end
      else
        flash[:notice] = "Senha atual incorreta ou as senhas não estão iguais."
      end
    else
      flash[:notice] = "A senha precisa ter no mínimo 8 caracteres."
    end
  end

private

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_url, notice: "Please sign in."
  end
end

def user_params
  params.require(:user).permit(:email, :name)
end
end
