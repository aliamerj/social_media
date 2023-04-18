# => id,email,password,username,avator,like(post),follow(user),comment(post)
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :likes
  has_many :comments

  validates :username, presence: true
  # The "!" is a convention used to indicate that
  # the method will modify the object it's called on.
  # In other words, the method has a side effect.
  def like!(post)
    # In Ruby, the << operator is called the "append" or "concatenate" operator.
    # It is commonly used to add an element to the end of an array or a string.
    likes << Like.new(post: post)
  end
  # TODO : add comment!(post)
  # TODO : add follow!(user)
end
