class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  after_create_commit :notify_recipient

  private

  def notify_recipient
    recipient = conversation.sender == user ? conversation.recipient : conversation.sender
    # Update this line to use the correct notification class
    ::MessageNotificationNotifier.with(message: self).deliver_later(recipient)
  end
end

