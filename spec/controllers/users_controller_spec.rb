require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  context 'GET' do
    it 'should be a valid Show Action ' do
      user = FactoryGirl.create(:user)
      get :show, id: user.id, format: 'json'
      response.should have_http_status(:ok)
    end  
    it 'should_not be a valid Show Action ' do
      user = FactoryGirl.create(:user)
      get :show, id: '' , format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end  
    it 'should_not be a valid Show Action ' do
      user = FactoryGirl.create(:user)
      get :show, id: '9278', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid New Action' do
      user = FactoryGirl.create(:user)
      get :new , format: 'json'
      response.should have_http_status(:ok)
    end   
    it 'should be a valid Edit Action' do
      user = FactoryGirl.create(:user)
      get :edit , format: 'json' ,id: user.id
      response.should have_http_status(:ok)
    end
    it 'should_not be a valid Edit Action' do
      user = FactoryGirl.create(:user)
      get :edit , format: 'json' ,id: ''
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should be a valid Index page' do
      users = User.all
      get :index, format: 'json'
      response.should have_http_status(:ok)
    end
  end

  context 'POST' do
    it 'should be a valid Create Action' do
      user = FactoryGirl.create(:user)
      post :create, user: { name: user.name, phone_no: user.phone_no, email: user.email, aadhar_no: user.aadhar_no }
      expect(response).to redirect_to(users_path)
    end
    it 'should_not have invalid Create Action' do
      post :create, user: { name: '', phone_no: '', email: '', aadhar_no: '' }, format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should be a valid Update Action' do
      user = FactoryGirl.create(:user)
      put :update, id: user.id, user: { name: user.name, phone_no: user.phone_no, email: user.email, aadhar_no: user.aadhar_no }
      expect(response).to redirect_to users_path
    end
    it 'should_not have invalid Update Action' do
      user = FactoryGirl.create(:user)
      put :update, format: 'json', id: user.id, user: { name: '', phone_no: '', email: '', aadhar_no: '' }
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Update Action' do
      user = FactoryGirl.create(:user)
      put :update, format: 'json', id: '', user: { name: '', phone_no: '', email: '', aadhar_no: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should have a valid Delete Action' do
      user = FactoryGirl.create(:user)
      delete :destroy, id: user.id
      expect(response).to redirect_to users_path
    end
    it 'should_not have invalid Delete Action' do
      user = FactoryGirl.create(:user)
      delete :destroy, id: '87987798', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
    it 'should_not have invalid Delete Action' do
      user = FactoryGirl.create(:user)
      delete :destroy, id: '', format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
