Rails.application.routes.draw do

  namespace :api do
    resources :games, only: [:show]
  end

end
