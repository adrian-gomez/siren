require 'rails_helper'

describe ReservationsController do

  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/reservations/new').to route_to('reservations#new')
    end

    it 'routes to #create' do
      expect(:post => '/reservations').to route_to('reservations#create')
    end

  end

end