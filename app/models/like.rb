# user_id, post_id
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
