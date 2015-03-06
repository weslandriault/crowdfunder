class Project < ActiveRecord::Base
	has_many :rewards
	has_many :pledges
	belongs_to :owner, class_name: 'User'

  def days_left
    self.end_date.mjd - self.start_date.mjd
  end

end
