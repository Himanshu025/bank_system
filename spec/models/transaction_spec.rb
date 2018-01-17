require 'rails_helper'
RSpec.describe Transaction, type: :model do
  context 'Transaction Creation' do
    it 'has a valid factory' do
      @transaction = FactoryGirl.create(:transaction).should be_valid
    end
  end

  context 'transaction Validation' do
    it 'is invalid without a number' do
      FactoryGirl.build(:transaction, number: nil).should_not be_valid
    end
    it 'is invalid without a category' do
      FactoryGirl.build(:transaction, category: nil).should_not be_valid
    end
    it 'is invalid without a amount' do
      FactoryGirl.build(:transaction, amount: nil).should_not be_valid
    end
    it 'should be valid number with length less_than_or_equal_to 5 ' do
      FactoryGirl.build(:transaction, number: '51200').should be_valid
    end
    it 'should be invalid number with length greater_than_or_equal_to 6 ' do
      FactoryGirl.build(:transaction, number: '89897765443').should_not be_valid
    end
    it 'should be valid number with numericality of integer ' do
      FactoryGirl.build(:transaction, number: '78765').should be_valid
    end
    it 'should be invalid number with numericality not equal_to integer ' do
      FactoryGirl.build(:transaction, number: 'abcd').should_not be_valid
    end
    it 'should be valid amount with length less_than_or_equal_to 8 ' do
      FactoryGirl.build(:transaction, amount: '676760').should be_valid
    end
    it 'should be invalid amount with length greater_than_or_equal_to 9 ' do
      FactoryGirl.build(:transaction, amount: '9000008800').should_not be_valid
    end
    it 'should be valid amount with numericality of integer ' do
      FactoryGirl.build(:transaction, amount: '78765').should be_valid
    end
    it 'should be invalid amount with numericality not equal_to integer ' do
      FactoryGirl.build(:transaction, amount: 'abcd').should_not be_valid
    end
  end

  context 'Transaction Associations' do
    it 'should belongs to account' do
      account = FactoryGirl.create(:account)
      transaction = FactoryGirl.create(:transaction, account_id: account.id)
      transaction.account.id.should eq account.id
    end
  end
end
