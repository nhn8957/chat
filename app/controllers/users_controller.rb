class UsersController < ApplicationController

	def index
		Rails.logger.info request.env["HTTP_COOKIE"]
  		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new user_params
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path, notice: "Account created."
		else
			render 'new'
		end
	end

	def received_messages
		Message.where(recipient: self)
	end

	def sent_messages
		Message.where(sender: self)
	end

	def latest_received_messages(n)
		received_messages.order(created_at: :desc).limit(n)
	end



private

	def user_params
		params.require(:user).permit(:name, :email, :password)
	end

end
