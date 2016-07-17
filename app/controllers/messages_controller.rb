class MessagesController < ApplicationController
	before_action :authenticate_user!

	def index
		@messages = Message.all
	end


	def new
		@friends = current_user.friends 
		@message = Message.new
	end

	def create
		current_user
    	@message = Message.new message_params
    	@message.sender_id = current_user.id
		if @message.save
			redirect_to root_path, notice: "Sent."
		else
			render :new
		end	
	end

	def show
    	@message = Message.find params[:id]
    	if @message.unread? && current_user == @message.recipient
      		@message.mark_as_read!
    	end
  	end

	
  
	def read?
	  	read_at
	end

	 def sent
    	load_user
    	@messages = @user.sent_messages
  	end
  
	def received
	    load_user
	    @messages = @user.received_messages
	end
	  
  	def load_user
    	if params[:user_id]
      	@user = User.find params[:user_id]
    	else
      	@user = current_user
    	end
  	end

	private
	def message_params
		params.require(:message).permit(:recipient_id, :body)
	end
end
