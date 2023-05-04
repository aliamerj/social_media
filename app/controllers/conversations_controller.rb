class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_new_conversation, only: [:show]

  def index
    @user = User.find(receiver_params)
    @conversations = current_user.conversations.order(created_at: :desc)
  end

  def show
    @conversation = Conversation.between(current_user, receiver_params)
    @messages = Message.where(conversation_id: @conversation.id)
  end

  def create
    @conversation = Conversation.between(current_user, receiver_params)
    unless @conversation.present?
      @conversation = Conversation.create(sender_id: current_user.id, receiver_id: receiver_params)
    end
    redirect_to @conversation
  end

  private

  def receiver_params
    params.require(:id)
  end

  def initialize_new_conversation
    return if Conversation.between(current_user, receiver_params).present?

    redirect_to user_path(receiver_params)
  end
end
