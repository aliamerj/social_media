class SaveMessageJob < ApplicationJob
  queue_as :default

  def perform(attributes)
    message = Message.new(attributes)
    message.save
  end
end
