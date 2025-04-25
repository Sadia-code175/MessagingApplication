class NotificationsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @notifications = current_user.notifications.order(created_at: :desc)
      current_user.notifications.unread.mark_as_read!
    end
  end