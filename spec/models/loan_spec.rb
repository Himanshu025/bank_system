require 'rails_helper'
RSpec.describe Loan, type: :model do
  context 'Loan Creation' do
    it 'has a valid factory' do
      @loan = FactoryGirl.create(:loan).should be_valid
    end
  end

  context 'Loan Validation' do
    it 'is invalid without a category' do
      FactoryGirl.build(:loan, category: nil).should_not be_valid
    end
    it 'is invalid without a no_of_years' do
      FactoryGirl.build(:loan, no_of_years: nil).should_not be_valid
    end
    it 'is invalid without a amount' do
      FactoryGirl.build(:loan, amount: nil).should_not be_valid
    end
    it 'should be valid amount with length less_than_or_equal_to 8 ' do
      FactoryGirl.build(:loan, amount: '676760').should be_valid
    end
    it 'should be invalid amount with length greater_than_or_equal_to 9 ' do
      FactoryGirl.build(:loan, amount: '9000008800').should_not be_valid
    end
    it 'should be valid amount with numericality of integer ' do
      FactoryGirl.build(:loan, amount: '78765').should be_valid
    end
    it 'should be invalid amount with numericality not equal_to integer ' do
      FactoryGirl.build(:loan, amount: 'abcd').should_not be_valid
    end
    it 'should be valid no_of_years with length less_than_or_equal_to 2 ' do
      FactoryGirl.build(:loan, no_of_years: '10').should be_valid
    end
    it 'should be invalid no_of_years with length greater_than_or_equal_to 3 ' do
      FactoryGirl.build(:loan, no_of_years: '1000').should_not be_valid
    end
    it 'should be valid no_of_years with numericality of integer ' do
      FactoryGirl.build(:loan, no_of_years: '10').should be_valid
    end
    it 'should be invalid no_of_years with numericality not equal_to integer ' do
      FactoryGirl.build(:loan, no_of_years: 'abcd').should_not be_valid
    end
  end

  context 'Loan Associations' do
    it 'should belongs to account' do
      account = FactoryGirl.create(:account)
      loan = FactoryGirl.create(:loan, account_id: account.id)
      loan.account.id.should eq account.id
    end
  end
end
