class Pledge < ActiveRecord::Base
	belongs_to :backer, class_name: 'User'
	belongs_to :project
  belongs_to :reward

  validates :project, :backer, presence: true
  validates :amount, numericality: {greater_than: 0}

  # def find_reward
  #   prospects = project.rewards.map do |reward|
  #     reward if reward.price <= amount
  #   end
  #   prospects.reject(&:nil?).sort.last
  # end
end
