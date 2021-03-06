Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  
  root to: "questions#index"
  resources :attachments, only: [:destroy]
  get 'search', to: 'search#index'

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
      end
      resources :questions do
        resources :answers, shallow: true
      end
    end
  end

  resources :users do
    collection do
      get :confirm_form
      post :confirmation
    end
  end
  
  concern :votable do
    member do
      patch :vote_up
      patch :vote_down
      delete :vote_cancel
    end
  end

  concern :commentable do
    resources :comments, shallow: true, only: [:create, :update, :destroy]
  end
  
  resources :questions, concerns: [:votable, :commentable] do
    member do
      post :subscribe
      delete :unscribe
    end
    resources :answers, shallow: true, concerns: [:votable, :commentable] do
      patch 'best', on: :member
    end
  end
end
