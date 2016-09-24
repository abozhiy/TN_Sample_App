Rails.application.routes.draw do
  devise_for :users
  
  root to: "questions#index"
  resources :attachments, only: [:destroy]
  
  
  concern :votable do
    member do
      patch :vote_up
      patch :vote_down
      delete :vote_cancel
    end
  end

 
  
  resources :questions, concerns: [:votable] do
    resources :comments, only: [:create, :update, :destroy], defaults: { commentable_type: 'question' }
    resources :answers, shallow: true, concerns: [:votable] do
      resources :comments, only: [:create, :update, :destroy], defaults: { commentable_type: 'answer' }
      patch 'best', on: :member
    end
  end
end
