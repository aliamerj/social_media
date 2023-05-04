class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :receiver, foreign_key: :receiver_id, class_name: 'User'
  has_many :messages, dependent: :destroy
  validates :sender, uniqueness: { scope: :receiver }
  def self.between(user1, user2)
    where(sender: user1, receiver: user2).or(where(sender: user2, receiver: user1)).first
  end
end
