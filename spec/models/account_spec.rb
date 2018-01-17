require 'rails_helper'
RSpec.describe Account, type: :model do
  context 'account Creation' do
    it 'has a valid factory' do
      @account = FactoryGirl.create(:account).should be_valid
    end
  end

  context 'Account Validation' do
    it 'is invalid without a balance' do
      FactoryGirl.build(:account, balance: nil).should_not be_valid
    end
    it 'is invalid without a number' do
      FactoryGirl.build(:account, number: nil).should_not be_valid
    end
    it 'should be valid number with length less_than_or_equal_to 8 ' do
      FactoryGirl.build(:account, number: '5111049').should be_valid
    end
    it 'should be invalid number with length greater_than_or_equal_to 9 ' do
      FactoryGirl.build(:account, number: '9000008800000').should_not be_valid
    end
    it 'should be valid number with numericality of integer ' do
      FactoryGirl.build(:account, number: '511100').should be_valid
    end
    it 'should be invalid number with numericality not equal_to integer ' do
      FactoryGirl.build(:account, number: 'abcd').should_not be_valid
    end
    it 'should be valid balance with length less_than_or_equal_to 8 ' do
      FactoryGirl.build(:account, balance: '5111049').should be_valid
    end
    it 'should be invalid balance with length greater_than_or_equal_to 9 ' do
      FactoryGirl.build(:account, balance: '9000008800000').should_not be_valid
    end
    it 'should be valid balance with numericality of integer ' do
      FactoryGirl.build(:account, balance: '511100').should be_valid
    end
    it 'should be invalid balance with numericality not equal_to integer ' do
      FactoryGirl.build(:account, balance: 'abcd').should_not be_valid
    end
  end

  context 'Account Association' do
    it 'should belongs to user' do
      user = FactoryGirl.create(:user)
      account = FactoryGirl.create(:account, user_id: user.id)
      account.user.id.should eq user.id
    end
    it 'should belongs to locker' do
      locker = FactoryGirl.create(:locker)
      account = FactoryGirl.create(:account, locker_id: locker.id)
      account.locker.id.should eq locker.id
    end
    it 'should have_many transactions' do
      account = FactoryGirl.create(:account)
      transaction1 = FactoryGirl.create(:transaction, account_id: account.id)
      transaction2 = FactoryGirl.create(:transaction, account_id: account.id)
      transaction1.account.id.should(eq account.id) && transaction2.account.id.should(eq account.id)
    end
    it 'should have_many loans' do
      account = FactoryGirl.create(:account)
      loan1 = FactoryGirl.create(:transaction, account_id: account.id)
      loan2 = FactoryGirl.create(:transaction, account_id: account.id)
      loan1.account.id.should(eq account.id) && loan2.account.id.should(eq account.id)
    end
  end
end
