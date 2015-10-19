Rails.application.routes.draw do
  root to: "home#index"
  blacklight_for :catalog
  
  resources :collections,
    only: [:show]
  
  resources :contact_us, path: '/about/contact_us',
    only: [:index]
  
  resources :about,
    only: [:show]
  
  resources :downloads,
    only: [:show]

  
end
