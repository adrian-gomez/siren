Rails.application.routes.draw do
  resources :reservations, :only => [:new, :create, :show] do
    member do
      get :confirm
      put :confirmation

      get :customize
      put :customization
    end
  end

  root 'reservations#new'

end