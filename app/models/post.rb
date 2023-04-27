#=> ID, user_id, body
class Post < ApplicationRecord
  has_one_attached :image do |att|
    att.variant :thumb, resize_to_limit: [100, 100]
  end
  belongs_to :user
  validates :body, presence: true,
                   length: { maximum: 500, minimum: 5 }
  has_many :comments, dependent: :destroy
  has_many :likes
  has_one :avatar, through: :user
end
