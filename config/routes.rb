Rails.application.routes.draw do
  
  devise_for :users
  resources :courses
  resources :users, only: [:index, :show, :edit, :update]
  root 'static_pages#landing_page'
  get 'landing_page', to: 'static_pages#landing_page'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'activity', to: 'static_pages#activity'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
