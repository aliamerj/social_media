class NewsMailer < ApplicationMailer
  def notification(user, post)
    @user = user
    @post = post
    mail(to: user.email, subject: 'New Post Notification')
  end
end
