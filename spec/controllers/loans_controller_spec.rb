require 'rails_helper'
RSpec.describe LoansController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action ' do
      loan = FactoryGirl.create(:loan)
      get :show, id: loan.id, format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Show Action ' do
      loan = FactoryGirl.create(:loan)
      get :show, id: '', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not be a valid Show Action ' do
      loan = FactoryGirl.create(:loan)
      get :show, id: '7168768', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid New Action' do
      loan = FactoryGirl.create(:loan)
      account = FactoryGirl.create(:account)
      get :new , account: account.id , format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Edit Action' do
      loan = FactoryGirl.create(:loan)
      get :edit , format: 'json' ,id: loan.id
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Edit Action' do
      loan = FactoryGirl.create(:loan)
      get :edit , format: 'json' ,id: ''
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do
    it 'should be a valid Create Action' do
      account = FactoryGirl.create(:account)
      loan = FactoryGirl.create(:loan)
      post :create, loan: { category: loan.category, amount: loan.amount, no_of_years: loan.no_of_years, account_id: account.id }
      expect(response).to redirect_to account_path(account.id)
    end
    it 'should_not have invalid Create Action' do
      account = FactoryGirl.create(:account)
      post :create, loan: { category: '', amount: '', no_of_years: '', account_id: account.id }
      expect(response).to redirect_to account_path(account.id)
    end
  end

  context 'PUT' do
    it 'should be a valid Update Action' do
      account = FactoryGirl.create(:account)
      loan = FactoryGirl.create(:loan)
      put :update, id: loan.id, loan: { category: loan.category, amount: loan.amount, no_of_years: loan.no_of_years, account_id: account.id }
      expect(response).to redirect_to account_path(account.id)
    end
    it 'should_not have invalid Update Action' do
      account = FactoryGirl.create(:account)
      loan = FactoryGirl.create(:loan)
      put :update, id: loan.id, format: 'json', loan: { category: '', amount: '', no_of_years: '', account_id: 'account.id' }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Update Action' do
      account = FactoryGirl.create(:account)
      loan = FactoryGirl.create(:loan)
      put :update, id: '', format: 'json', loan: { category: '', amount: '', no_of_years: '', account_id: 'account.id' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should have a valid Delete Action' do
      loan = FactoryGirl.create(:loan)
      delete :destroy, id: loan.id, format: :json
      response.should have_http_status(:ok)
    end
    it 'should_not have invalid Delete Action' do
      loan = FactoryGirl.create(:loan)
      delete :destroy, id: ''
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Delete Action' do
      loan = FactoryGirl.create(:loan)
      delete :destroy, id: 'acnab'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
