require 'rails_helper'

describe ReservationsController do

  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/reservations/new').to route_to('reservations#new')
    end

    it 'routes to #create' do
      expect(:post => '/reservations').to route_to('reservations#create')
    end

    it 'routes to #confirm' do
      expect(:get => '/reservations/1/confirm').to route_to('reservations#confirm', id: '1')
    end

    it 'routes to #confirmation' do
      expect(:put => '/reservations/1/confirmation').to route_to('reservations#confirmation',
                                                                 id: '1')
    end

    it 'routes to #customize' do
      expect(:get => '/reservations/1/customize').to route_to('reservations#customize', id: '1')
    end

    it 'routes to #customization' do
      expect(:put => '/reservations/1/customization').to route_to('reservations#customization',
                                                                  id: '1')
    end

    it 'routes to #rate' do
      expect(:get => '/reservations/1/rate').to route_to('reservations#rate', id: '1')
    end

    it 'routes to #rating' do
      expect(:put => '/reservations/1/rating').to route_to('reservations#rating', id: '1')
    end

  end

end