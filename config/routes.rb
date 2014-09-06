Rails.application.routes.draw do
  resources :reservations, :only => [:new, :create] do
    member do
      get :confirm
    end

  end

  root 'reservations#new'

end