require 'rails_helper'

RSpec.describe User, type: :model do

  #before(:each) do
  #  subject = FactoryGirl.build(:user)
  #end
  context 'model validations' do
    
    it 'should be valid' do
      user = FactoryGirl.build(:user)
      Rails.logger.debug "----Factory: #{user.inspect}"
      expect(user.valid?).to eq(true)
    end

    it 'should not be valid when name is blank' do
      user = FactoryGirl.build(:user, name: "")
      expect(user.valid?).to eq(false)
    end

    it 'should not be valid when email is blank' do
      user = FactoryGirl.build(:user, email: "")
      expect(user.valid?).to eq false
    end

  end
end
