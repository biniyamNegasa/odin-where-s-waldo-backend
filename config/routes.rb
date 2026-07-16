Rails.application.routes.draw do
  namespace :api do
    get "leaderboard/:image_name", to: "leaderboards#show", as: :leaderboard

    resources :timers, only: %i[create update] do
      member do
        post :check
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
