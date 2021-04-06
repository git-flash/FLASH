Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  get 'users/pending'


  resources :committees
  resources :attendance_committee
  #resources :users
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
