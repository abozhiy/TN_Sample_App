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
  
  resources :questions, concerns: :votable do
    resources :answers, shallow: true, concerns: :votable do
      patch 'best', on: :member
    end
  end
end
