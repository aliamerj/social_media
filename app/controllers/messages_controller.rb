class MessagesController < ApplicationController
  def create

    @message = Message.new(message_params)
    if @message.save
      # do something on successful save
    else
      flash[:error] = "There was an error saving your message."
      redirect_back(fallback_location: root_path)
    end
  end

  def message_params
    params.permit(:conversation_id, :body, :sender_id)
  end

end
