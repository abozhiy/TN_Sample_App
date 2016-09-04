Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, shallow: true
      patch 'best/:id', to: 'answers#best', as: 'best_answer'
  end

  root to: "questions#index"
end
