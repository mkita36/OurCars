Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registration: 'admins/registrations'
  }
  devise_scope :admin do
    get '/admins/sign_out', to: 'devise/sessions#destroy'
  end

  devise_for :managers, controllers: {
    sessions: 'managers/sessions',
    passwords: 'managers/passwords',
    registration: 'managers/registrations'
  }
  devise_scope :manager do
    get '/managers/sign_out', to: 'devise/sessions#destroy'
  end
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registration: 'users/registrations'
  }
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  

  namespace :admin do
    resources :companies, except: [:show] do
      resources :managers, except: [:show]
    end
  end

  resources :companies, only: [] do
    resources :status, only: [:index]
    resources :uses, except: [:show]
    resources :cars, only: [] do
      resources :uses, except: [:show]
      get '/ride', to: 'status#ride'
      get '/no_ride', to: 'status#no_ride'
      resources :reservations, only: [:index, :new, :create, :destroy]
    end

    namespace :manager do
      resources :managers, except: [:show]
      resources :users, except: [:show] do
        resources :cards, only: [:edit, :update]
      end
      get '/monthly_report', to: 'cars#monthly_report'
      get '/half_period_report', to: 'cars#half_period_report'
      resources :cars do
        resources :uses, except: [:show]
        resources :inspections, except: [:show]
        resources :memos, except: [:show]
      end
    end
  end
end