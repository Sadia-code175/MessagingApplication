
# app/notifiers/application_notifier.rb
class ApplicationNotifier < Noticed::Event
    # Define delivery methods that all notifications will use
    deliver_by :database
    
    # Common parameters available to all notifications
    param :event_time, default: -> { Time.current }
    
    # URL helpers for notifications
    include Rails.application.routes.url_helpers
    
    # Default URL options
    def default_url_options
      Rails.application.config.action_mailer.default_url_options || {}
    end
  
    # Common method to get the associated record
    def record
      params[:record]
    end
  
    # Default message that can be overridden by specific notifications
    def message
      "You have a new notification"
    end
  
    # Default URL that points to the record if available
    def url
      record
    end
  
    # Common method to get the sender of the notification
    def sender
      params[:sender] || User.default_admin
    end
  
    # Email configuration that child notifications can override
    def mailer
      'NotificationMailer'
    end
  
    # Helper method for I18n translations
    def t(key, **options)
      I18n.t("notifications.#{self.class.name.underscore}.#{key}", **options)
    end
  
    # Add any other common methods your notifications might need
  end