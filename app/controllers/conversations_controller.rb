
class ConversationsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @conversations = current_user.conversations.includes(:recipient, :messages)
    end
  
    def show
      @conversation = Conversation.find(params[:id])
      @messages = @conversation.messages.order(created_at: :asc)
      @message = Message.new
    end


    def new
        @conversation = Conversation.new
        @users = User.where.not(id: current_user.id)
    end
    # app/controllers/conversations_controller.rb
def create
    recipient = User.find_by(id: params[:conversation][:recipient_id])
    
    if recipient.nil?
      flash[:alert] = "Please select a valid user"
      redirect_to new_conversation_path and return
    end
  
    if current_user.id == recipient.id
      flash[:alert] = "Cannot start conversation with yourself"
      redirect_to new_conversation_path and return
    end
  
    @conversation = Conversation.between(current_user.id, recipient.id).first_or_initialize
    @conversation.sender = current_user
    @conversation.recipient = recipient
  
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      @users = User.where.not(id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end
  end