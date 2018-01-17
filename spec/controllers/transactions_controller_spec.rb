require 'rails_helper'
RSpec.describe TransactionsController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action ' do
      transaction = FactoryGirl.create(:transaction)
      get :show, id: transaction.id, format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Show Action ' do
      transaction = FactoryGirl.create(:transaction)
      get :show, id: '', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do
    it 'should be a valid Create Action' do
      transaction = FactoryGirl.create(:transaction)
      account = FactoryGirl.create(:account)
      post :create, format: 'json', transaction: { number: '567', category: transaction.category, amount: transaction.amount, account_id: account.id }
      response.should have_http_status(:ok)
    end
    it 'should be a valid Create Action' do
      transaction = FactoryGirl.create(:transaction)
      account = FactoryGirl.create(:account)
      post :create, format: 'json', transaction: { number: '789', category: 'withdraw', amount: transaction.amount, account_id: account.id }
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Create Action' do
      transaction = FactoryGirl.create(:transaction)
      account = FactoryGirl.create(:account)
      post :create, format: 'json', transaction: { number: '789', category: 'withdraw', amount: '789876', account_id: account.id }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Create Action' do
      account = FactoryGirl.create(:account)
      post :create, transaction: { number: '', category: '', amount: '', account_id: account.id }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should be a valid Update Action' do
      transaction = FactoryGirl.create(:transaction)
      account = FactoryGirl.create(:account)
      put :update, id: transaction.id,format: 'json', transaction: { number: '789', category: transaction.category, amount: transaction.amount, account_id: account.id }
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Update Action' do
      transaction = FactoryGirl.create(:transaction)
      account = FactoryGirl.create(:account)
      put :update, id:'',format: 'json', transaction: { number: '789', category: transaction.category, amount: transaction.amount, account_id: account.id }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not be a valid Update Action' do
      transaction = FactoryGirl.create(:transaction)
      account = FactoryGirl.create(:account)
      put :update, id:transaction.id,format: 'json', transaction: { number: '', category: '', amount: '', account_id: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should have a valid Delete Action' do
      transaction = FactoryGirl.create(:transaction)
      delete :destroy, id: transaction.id, format: :json
      response.should have_http_status(:ok)
    end
    it 'should_not have invalid Delete Action' do
      transaction = FactoryGirl.create(:transaction)
      delete :destroy, id: '', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
