Rails.application.routes.draw do
  resources :users
  resources :accounts
  resources :loans
  resources :lockers
  resources :transactions
end
