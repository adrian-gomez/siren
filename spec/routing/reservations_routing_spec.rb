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
      expect(:put => '/reservations/1/confirmation').to route_to('reservations#confirmation', id: '1')
    end

  end

end