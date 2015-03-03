class Project < ActiveRecord::Base
	has_many :rewards
	has_many :pledges
	belongs_to :owner, class_name: 'User'
end
