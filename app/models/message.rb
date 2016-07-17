class Message < ApplicationRecord
	belongs_to :sender, class_name: 'User'
	belongs_to :recipient, class_name: 'User'

	scope :unread, -> { where(read_at: nil) }

	def sender_name
		@sender = User.find(self.sender.id)
		@sender.name
	end

	def recipient_name
		@recipient = User.find(self.recipient.id)
		@recipient.name
	end

	def mark_as_read!
        if self.read_at == nil
        	self.read_at = Time.now.in_time_zone("Hanoi").to_s(:short)
    		save!
    	end
  	end

	def read?
    	read_at
  	end

end
