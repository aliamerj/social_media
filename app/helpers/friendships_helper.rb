module FriendshipsHelper
  def send_notification_to_friends(user, post)
    friend_ids = Friendship.where(user_id: user.id).pluck(:friend_id)
    User.where(id: friend_ids).each do |friend|
      NewsMailer.notification(friend, post).deliver_later
    end
  end
end
