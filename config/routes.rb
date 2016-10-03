Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  
  root to: "questions#index"
  resources :attachments, only: [:destroy]
  
  
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
    resources :answers, shallow: true, concerns: [:votable, :commentable] do
      patch 'best', on: :member
    end
  end
end
