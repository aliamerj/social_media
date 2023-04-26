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

  # Define a many-to-many association with itself for friendships
  has_many :friendships
  # define has_many :friends, through: :friendships, source: :friend,
  # you are telling Rails to look for the friend association
  # in the Friendship model, which is a join table between
  # two instances of the User model.
  # This allows you to access the friends of a user through the Friendship model.
  has_many :users, through: :friendships, source: :friend

  # The "!" is a convention used to indicate that
  # the method will modify the object it's called on.
  # In other words, the method has a side effect.
  def like!(post)
    # In Ruby, the << operator is called the "append" or "concatenate" operator.
    # It is commonly used to add an element to the end of an array or a string.
    likes << Like.new(post: post)
  end


  # Define a helper method to add a friend
  def add_friend!(user)
    Friendship.create(user: self, friend: user)
  end

  # Define a helper method to remove a friend
  def remove_friend!(user)
    Friendship.where(user: self, friend: user).delete_all
  end
end
