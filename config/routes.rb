Rails.application.routes.draw do

  namespace :api do
    resources :games, only: [:index, :show, :create] do
      member do
        post :reveal
      end
    end
  end

  root 'home#index'

end
