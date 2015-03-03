require 'rails_helper'

RSpec.describe Pledge do
  let(:user) { User.create(email: 'j@j.com', password: 'foo', password_confirmation: 'foo')}
  let(:project) { Project.create(
    name: 'whatever', start_date: 10.days.ago, end_date: 2.years.from_now,
    description: 'its super neato', funding_goal: 1_000_000, owner: user)
  }
  let(:reward) { Reward.create(name: 'Awesome Reward', description: "It is awesome", price: 2000, project: project)}
  let(:pledge) { Pledge.new(backer: user, project: project, amount: 2000) }

  describe 'creating a pledge' do
    it 'requires a project and user' do 
      expect(pledge.save).to be(true)
    end

    it 'does not create the pledge if the user is missing' do
      pledge.backer = nil
      expect(pledge.save).to be(false)
      expect(pledge.errors[:backer]).to be_present
    end

    it 'does not create the pledge if the project is missing' do
      pledge.project = nil
      expect(pledge.save).to be(false)
      expect(pledge.errors[:project]).to be_present
    end

    it 'does not create the pledge if the amount is not greater than zero' do
      pledge.amount = 0
      expect(pledge.save).to be(false)
      expect(pledge.errors[:amount]).to be_present
    end
  end

  describe '#reward' do
    let(:better_reward) { Reward.create(
      name: 'Awesomer Reward', description: 'This will make you super cool',
      price: 50_000, project: project
    )}
    before(:each) do
      reward #herp derp just making sure it is created
      better_reward
    end
    it 'returns the highest available reward for the pledge' do
      pledge.amount = better_reward.price - 1
      expect(pledge.find_reward).to eq(reward)
    end

    it 'does not return a reward if the pledge amount is not enough' do
      pledge.amount = reward.price - 1
      expect(pledge.find_reward).to be_nil
    end
  end
end