Rails.application.routes.draw do
  resources :reservations, :only => [:new, :create] do
    member do
      get :confirm
      put :confirmation

      get :customize
      put :customization

      get :rate
      put :rating
    end
  end

  root 'reservations#new'

end