class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true


 def self.search(search)
 if search
  where('title LIKE ?', "%#{search}%")
 else
  all
 end  	
end

end
