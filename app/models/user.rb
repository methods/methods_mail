class User < ActiveRecord::Base
	has_many :contacts, dependant: :destroy
end
