Rails.application.routes.draw do

  namespace :api do
    resources :games, only: [:index, :show] do
      member do
        post :reveal
      end
    end
  end

end
