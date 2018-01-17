require 'rails_helper'
RSpec.describe User, type: :model do
  context 'User Creation' do
    it 'has a valid factory' do
      @user = FactoryGirl.create(:user).should be_valid
    end
  end

  context 'User Validation' do
    it 'is invalid without a name' do
      FactoryGirl.build(:user, name: nil).should_not be_valid
    end
    it 'is invalid without a email' do
      FactoryGirl.build(:user, email: nil).should_not be_valid
    end
    it 'is invalid without a phone_no' do
      FactoryGirl.build(:user, phone_no: nil).should_not be_valid
    end
    it 'is invalid without a aadhar_no' do
      FactoryGirl.build(:user, aadhar_no: nil).should_not be_valid
    end
    it 'should be valid name with length greater_than_or_equal_to 3 ' do
      FactoryGirl.build(:user, name: 'abhishek').should be_valid
    end
    it 'should be invalid name with length less_than_or_equal_to 2 ' do
      FactoryGirl.build(:user, name: 'ab').should_not be_valid
    end
    it 'should be valid email with proper regular expression' do
      FactoryGirl.build(:user, email: 'abc@gmail.com').should be_valid
    end
    it 'should be invalid email with improper regular expression' do
      FactoryGirl.build(:user, email: '1^67abcd').should_not be_valid
    end
    it 'should be valid phone_no with length greater_than_or_equal_to 7 and less_than_or_equal_to 12' do
      FactoryGirl.build(:user, phone_no: '9988779843').should be_valid
    end
    it 'should be invalid phone_no with length less_than_or_equal_to 6 and greater_than_or_equal_to 13' do
      FactoryGirl.build(:user, phone_no: '09876').should_not be_valid
    end
    it 'should be valid aadhar_no with length equal_to 12 ' do
      FactoryGirl.build(:user, aadhar_no: '878799098765').should be_valid
    end
    it 'should be invalid aadhar_no with length not equal_to 12 ' do
      FactoryGirl.build(:user, aadhar_no: '09876').should_not be_valid
    end
    it 'should be valid aadhar_no with numericality of integer ' do
      FactoryGirl.build(:user, aadhar_no: '878799098765').should be_valid
    end
    it 'should be invalid aadhar_no with numericality not equal_to integer ' do
      FactoryGirl.build(:user, aadhar_no: 'abcd').should_not be_valid
    end
  end

  context 'User Associations' do
    it 'should_have many accounts' do
      user = FactoryGirl.create(:user)
      account1 = FactoryGirl.create(:account, user_id: user.id)
      account2 = FactoryGirl.create(:account, user_id: user.id)
      account1.user.id.should(eq user.id) && account2.user.id.should(eq user.id)
    end
  end
end
