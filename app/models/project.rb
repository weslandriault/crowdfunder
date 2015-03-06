class Project < ActiveRecord::Base
	has_many :rewards
	has_many :pledges
	belongs_to :owner, class_name: 'User'

  def days_left
    self.end_date.mjd - self.start_date.mjd
  end

  def progress
    self.amount_raised.to_f / self.funding_goal.to_f * 100
  end

end
