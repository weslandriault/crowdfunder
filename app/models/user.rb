class User < ActiveRecord::Base
  has_many :projects
  has_many :pledges, foreign_key: :backer_id
  has_many :rewards, through: :pledges
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  
end
