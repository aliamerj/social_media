# => id,email,password,username,avator,like(post),follow(user),comment(post)
class User < ApplicationRecord
  attr_accessor :current_password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :likes
  has_many :comments
  belongs_to :avatar
  validates :username, presence: true
  # dependent: :destroy to the association,
  # which means that when a User is deleted,
  # all associated Conversations will be deleted as well.
  # This is usually the behavior you want for a dependent association.
  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
  has_many :messages, through: :conversations
  # Define a many-to-many association with itself for friendships
  has_many :friendships
  # define has_many :friends, through: :friendships, source: :friend,
  # you are telling Rails to look for the friend association
  # in the Friendship model, which is a join table between
  # two instances of the User model.
  # This allows you to access the friends of a user through the Friendship model.
  has_many :followers, through: :friendships, source: :user
  has_many :followings, through: :friendships, source: :friend

  # The "!" is a convention used to indicate that
  # the method will modify the object it's called on.
  # In other words, the method has a side effect.
  def like!(post)
    # In Ruby, the << operator is called the "append" or "concatenate" operator.
    # It is commonly used to add an element to the end of an array or a string.
    likes << Like.new(post: post)
  end


  # Define a helper method to follow
  def follow!(user)
    Friendship.create(user: user, friend: self)
  end

  # Define a helper method to unfollow
  def unfollow!(user)
    Friendship.where(user: user, friend: self).delete_all
  end

  def followers_count
    Friendship.where(user_id: self.id).count
  end

  def followings_count
    Friendship.where(friend_id: self.id).count
  end
end
