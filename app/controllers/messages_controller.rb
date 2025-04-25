class MessagesController < ApplicationController
    before_action :authenticate_user!
  
    def create
        @conversation = Conversation.find(params[:conversation_id])
        @message = @conversation.messages.new(message_params)
        @message.user = current_user
      
        respond_to do |format|
          if @message.save
            format.turbo_stream
            format.html { redirect_to conversation_path(@conversation) }
          else
            format.turbo_stream { render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form", locals: { conversation: @conversation, message: @message }) }
            format.html { render :new }
          end
        end
      end
      
    def new
        @conversation = Conversation.find(params[:conversation_id])
        @message = Message.new
      end
  
    private
  
    def message_params
      params.require(:message).permit(:body)
    end
  end