class MessageNotificationNotifier < ApplicationNotifier
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"

  param :message

  def message
    params[:message]
  end

  def url
    # URL where the notification should link to
    conversation_path(params[:message].conversation)
  end
  # Add your delivery methods

end
