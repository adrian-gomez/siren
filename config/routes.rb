Rails.application.routes.draw do
  resources :reservations, :only => [:new, :create] do
    member do
      get :confirm
      put :confirmation

      get :customize
    end

  end

  root 'reservations#new'

end