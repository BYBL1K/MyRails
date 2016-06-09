class User < ActiveRecord::Base

	# ассоциации
	has_one :cart
	has_many :orders
	has_many :comments

end
