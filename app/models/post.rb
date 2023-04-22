#=> ID, user_id, body
class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true,
                   length: { maximum: 500, minimum: 5 }
  has_many :comments, dependent: :destroy
  # TODO : has many likes
  has_many :likes
end
