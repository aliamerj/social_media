class MessagesController < ApplicationController
  def create

    @message = Message.new(message_params)
    if @message.valid?
      SaveMessageJob.perform_later(@message.attributes)
      # Broadcast the new message to the conversation's chat channel
      ChatChannel.broadcast_to(@message.conversation_id, @message.as_json(
                                only: [:body],
                                include: {
                                  sender: { only: [:id], include: [:avatar] },
                                }
                              )
                              )
      head :ok
    else
      flash[:error] = "There was an error saving your message."
      redirect_back(fallback_location: root_path)
    end
  end

  def message_params
    params.permit(:conversation_id, :body, :sender_id)
  end

end
