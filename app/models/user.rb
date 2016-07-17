class User < ApplicationRecord
	validates :name , presence: true
	validates :email, presence: true, uniqueness: {case_insensitive: false}
	has_secure_password

	has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id  
	has_many :received_messages, class_name: 'Message', foreign_key: :recipient_id  

	def friends
		User.where('id != ?', self.id)		
	end

	def received_messages
    	Message.where(recipient_id: self)
  	end

  	def sent_messages
    	Message.where(sender_id: self)
  	end

  	def latest_received_messages(n)
    	received_messages.order(created_at: :desc).limit(n)
  	end

	def unread_messages
		received_messages.unread
	end

end
