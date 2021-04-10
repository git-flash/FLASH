Rails.application.routes.draw do
  devise_for :users
  as :users do
    # get 'users/sign_in', :to => 'devise/sessions#new', :as => :registration
  end
  root 'events#index'
  get 'users/pending'

  resources :committees
  resources :attendance_committee
  resources :attendance_user

  resources :events do
    member do
      get :delete
    end
  end

  resources :rsvps do
    member do
      get :delete
    end
  end

  resources :users do
    member do
      get :soft_delete
    end
  end

  resources :attendance_logs do
    member do
      get :delete
    end
  end
end
