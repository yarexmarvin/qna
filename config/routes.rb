Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  resources :questions, shallow: true do
    resources :answers, shallow: true, except: :index
  end
end
