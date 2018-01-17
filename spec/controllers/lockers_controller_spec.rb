require 'rails_helper'
RSpec.describe LockersController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action ' do
      locker = FactoryGirl.create(:locker)
      get :show, id: locker.id, format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Show Action ' do
      locker = FactoryGirl.create(:locker)
      get :show, id: '6768789', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not be a valid Show Action ' do
      locker = FactoryGirl.create(:locker)
      get :show, id: '', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid New Action ' do
      locker = FactoryGirl.create(:locker)
      get :new, format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Index page' do
      lockers = Locker.all
      get :index, format: 'json'
      response.should have_http_status(:ok)
    end
    it 'should be a valid Edit Action' do
      locker = FactoryGirl.create(:locker)
      get :edit , format: 'json' ,id: locker.id
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Edit Action' do
      locker = FactoryGirl.create(:locker)
      get :edit , format: 'json' ,id: ''
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do
    it 'should be a valid Create Action' do
      locker = FactoryGirl.create(:locker)
      post :create, locker: { section: locker.section, number: locker.number }
      expect(response).to redirect_to(lockers_path)
    end
    it 'should_not have invalid Create Action' do
      post :create, format: 'json', locker: { section: 'nil', number: 'abc' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should be a valid Update Action' do
      locker = FactoryGirl.create(:locker)
      put :update, id: locker.id, locker: { section: locker.section, number: locker.number }
      expect(response).to redirect_to lockers_path
    end
    it 'should_not have invalid Update Action' do
      locker = FactoryGirl.create(:locker)
      put :update, id: locker.id, locker: { section: '', number: '' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Update Action' do
      locker = FactoryGirl.create(:locker)
      put :update, id: '', locker: { section: '', number: '' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should have a valid Delete Action' do
      locker = FactoryGirl.create(:locker)
      delete :destroy, id: locker.id
      expect(response).to redirect_to lockers_path
    end
    it 'should_not have invalid Delete Action' do
      locker = FactoryGirl.create(:locker)
      delete :destroy, id: 'iyy8hj'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Delete Action' do
      locker = FactoryGirl.create(:locker)
      delete :destroy, id: ''
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
