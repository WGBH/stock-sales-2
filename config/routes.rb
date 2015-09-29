Rails.application.routes.draw do
  root to: "home#index"
  blacklight_for :catalog
  
  resources :collections,
    only: [:show]
  
  resources :contact_us, path: '/about/contact_us',
    only: [:index, :new]
  
  resources :about,
    only: [:show]

  
end
