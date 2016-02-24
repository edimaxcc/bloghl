class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    if user.admin?
     can :manage, :all
    else
     can :destroy, Post do |post|
      post.user == user
     end
     can :update, Post do |post|
      post.user == user
     end       
     can :destroy, Comment do |comment|
      comment.user == user
     end
     can :update, Comment do |comment|
      comment.user == user
     end
     can :create, Post
     can :create, Comment
     can :read, Post
     can :read, Comment
    end
   end 
 end
