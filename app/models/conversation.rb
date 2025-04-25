class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :messages, dependent: :destroy

  validate :sender_and_recipient_different
  validates_uniqueness_of :sender_id, scope: :recipient_id
  validate :cannot_message_self
# app/models/conversation.rb
def self.between(sender_id, recipient_id)
  where(
    "(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)",
    sender_id, recipient_id, recipient_id, sender_id
  )
end
  private

  def sender_and_recipient_different
    errors.add(:base, "Cannot start conversation with yourself") if sender_id == recipient_id
  end
  
  def cannot_message_self
    errors.add(:base, "Cannot message yourself") if sender_id == recipient_id
  end
end


