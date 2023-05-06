class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :receiver, foreign_key: :receiver_id, class_name: 'User'
  has_many :messages, dependent: :destroy
  validates :sender, uniqueness: { scope: :receiver }

  def self.between(user1_id, user2_id)
    where(sender_id: user1_id, receiver_id: user2_id).or(where(sender_id: user2_id, receiver_id: user1_id)).first
  end
end
