Rails.application.routes.draw do
  
  devise_for :users
  root 'events#index'

  resources :users do
    member do
      get :delete
    end
  end

  resources :committees do
    member do
      get :delete
    end
  end

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

  resources :attendance_logs do
    member do
      get :delete
    end
  end
  
end
