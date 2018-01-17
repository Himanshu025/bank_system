require 'rails_helper'
RSpec.describe AccountsController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action ' do
      account = FactoryGirl.create(:account)
      get :show, id: account.id, format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Index page' do
      accounts = Account.all
      get :index, format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Show Action ' do
      account = FactoryGirl.create(:account)
      get :show, id: '99787', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not be a valid Show Action ' do
      account = FactoryGirl.create(:account)
      get :show, id: '', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid New Action ' do
      account = FactoryGirl.create(:account)
      get :new, format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Edit Action' do
      account = FactoryGirl.create(:account)
      get :edit , format: 'json' ,id: account.id
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Edit Action' do
      account = FactoryGirl.create(:account)
      get :edit , format: 'json' ,id: ''
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do
    it 'should be a valid Create Action' do
      account = FactoryGirl.create(:account)
      locker = FactoryGirl.create(:locker)
      post :create,format: 'json', account: { number: '8902', balance: account.balance, user_id: account.user_id, locker_id: locker.id }
      response.should have_http_status(:ok)
    end
    it 'should_not have invalid Create Action' do
      user = FactoryGirl.create(:user)
      post :create,format: 'json', account: { number: '', user_id: user.id }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should be a valid Update Action' do
      account = FactoryGirl.create(:account)
      user = FactoryGirl.create(:user)
      locker = FactoryGirl.create(:locker)
      put :update, id: account.id, account: { number: account.number, balance: account.balance, user_id: user.id, locker_id: locker.id }
      expect(response).to redirect_to user_path(user.id)
    end
    it 'should_not have invalid Update Action' do
      account = FactoryGirl.create(:account)
      put :update, id: account.id, account: { number: '', balance: '', user_id: '', locker_id: '' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Update Action' do
      account = FactoryGirl.create(:account)
      put :update, id: '', account: { number: '', balance: '', user_id: '', locker_id: '' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should have a valid Delete Action' do
      account = FactoryGirl.create(:account)
      delete :destroy, format: :json, id: account.id
      response.should have_http_status(:ok)
    end
    it 'should_not have invalid Delete Action' do
      account = FactoryGirl.create(:account)
      delete :destroy, id: ''
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Delete Action' do
      account = FactoryGirl.create(:account)
      delete :destroy, id: 'abdb'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
