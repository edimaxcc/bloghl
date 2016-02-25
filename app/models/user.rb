class User < ActiveRecord::Base
 
  acts_as_messageable
   
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :sessions
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :messages 
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower 


  


    #follow users 
  def follow(other_user)
   active_relationships.create(followed_id: other_user.id)
  end

  #Unfollows user
  def unfollow(other_user)
   active_relationships.find_by(followed_id: other_user).destroy
  end

  #Return true if de current_user is following the other user
  def following?(other_user)
   following.include?(other_user)
  end

  #Feeds Return post from the current_user
  def feed
  Post.where("user_id = ?", id)
  end

  #Def Method for mailboxer
  def mailboxer_email(object)
   return email
  end

end
