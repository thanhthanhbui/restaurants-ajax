Rails.application.routes.draw do
  root "rests#index"

  get "rest_form", to: "rests#form"

  resources :rests do
    resources :foods
  end
end
