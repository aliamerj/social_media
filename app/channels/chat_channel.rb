class ChatChannel < ApplicationCable::Channel
  def subscribed
    $stdout.puts(":x subscribed chat_#{params[:conversation_id]} ")
    stream_for params[:conversation_id]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    # Here you can handle the message received from the user
    # and broadcast it to other users subscribed to the channel.

     puts ":x the message is #{data} "
    #ActionCable.server.broadcast("chat_#{params[:conversation_id]}", data)
  end
end
