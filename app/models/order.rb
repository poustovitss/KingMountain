class Order < ApplicationRecord
	def is_ik_payment_valid?(ik_cur, ik_am)
	 ( self.currency == ik_cur and self.total == ik_am )
	end
  	belongs_to :user
end
