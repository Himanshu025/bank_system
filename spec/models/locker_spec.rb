require 'rails_helper'
RSpec.describe Locker, type: :model do
  context 'Locker Creation' do
    it 'has a valid factory' do
      @locker = FactoryGirl.create(:locker).should be_valid
    end
  end

  context 'Locker Validation' do
    it 'is invalid without a section' do
      FactoryGirl.build(:locker, section: nil).should_not be_valid
    end
    it 'is invalid without a number' do
      FactoryGirl.build(:locker, number: nil).should_not be_valid
    end
    it 'should be valid number with length less_than_or_equal_to 5 ' do
      FactoryGirl.build(:locker, number: '550').should be_valid
    end
    it 'should be invalid number with length greater_than_or_equal_to 6 ' do
      FactoryGirl.build(:locker, number: '9000008800').should_not be_valid
    end
    it 'should be valid number with numericality of integer ' do
      FactoryGirl.build(:locker, number: '500').should be_valid
    end
    it 'should be invalid number with numericality not equal_to integer ' do
      FactoryGirl.build(:locker, number: 'abcd').should_not be_valid
    end
  end
end
