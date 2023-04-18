#=> ID, user_id, post_id, body
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true,
                   length: { maximum: 500, minimum: 5 }
end
