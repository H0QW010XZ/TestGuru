Rails.application.routes.draw do
  root 'tests#index'

  get :signup, to: 'users#new'
  get :signin, to: 'sessions#new'

  delete :logout, to: 'sessions#destroy'

  resources :sessions, only: %i[create destroy]
  resources :users, only: :create

  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    post :start, on: :member
  end

  resources :test_passages, only: %i[show update] do
    get :result, on: :member
  end
end
