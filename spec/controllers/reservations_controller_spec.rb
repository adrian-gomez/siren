require 'rails_helper'

describe ReservationsController do

  describe 'GET new' do

    it 'assigns a new reservation as @reservation' do
      get :new

      expect(assigns(:reservation)).to be_a_new(Reservation)
    end

  end

  describe 'POST create' do

    context 'with valid params' do

      let(:valid_attributes) { attributes_for(:reservation) }

      it 'creates a new Reservation' do
        expect {
          post :create, { :reservation => valid_attributes }
        }.to change(Reservation, :count).by(1)
      end

      it 'sends and message to the given email' do
        post :create, { :reservation => valid_attributes }

        email = ActionMailer::Base.deliveries.last

        expect(email.to).to include(valid_attributes[:email])
        expect(email.subject).to eq(I18n.t('mailers.reservation.confirm'))
      end

      it 'redirects to a new reservation' do
        post :create, { :reservation => valid_attributes }

        expect(response).to redirect_to(new_reservation_path)
      end

      it 'adds a success flash message' do
        post :create, { :reservation => valid_attributes }

        expect(flash[:notice]).to eq(I18n.t('reservation.created'))
      end

      describe 'the created reservation' do

        before { post :create, { :reservation => valid_attributes } }

        subject { Reservation.last }

        its(:email) { should eq(valid_attributes[:email]) }
      end

    end

    context 'with invalid params' do

      let(:invalid_attributes) { { :email => 'im_not_a_valid_email.org' }}

      it 'assigns a newly created but unsaved reservation as @reservation' do
        post :create, { :reservation => invalid_attributes }

        expect(assigns(:reservation)).to be_a_new(Reservation)
      end

      it 'keeps the given params' do
        post :create, { :reservation => invalid_attributes }

        expect(assigns(:reservation).email).to eq(invalid_attributes[:email])
      end

      it 're-renders the new template' do
        post :create, { :reservation => invalid_attributes }

        expect(response).to render_template(:new)
      end
    end

  end

  describe 'GET confirm' do

    let(:reservation) { create(:reservation) }

    it 'assigns the reservation as @reservation' do
      get :confirm, { id: reservation.to_param }

      expect(assigns(:reservation)).to eq(reservation)
    end

    context 'when the reservation is confirmed' do
      let(:reservation) { create(:reservation, :confirmed) }

      it 'assigns the reservation as @reservation' do
        get :confirm, { id: reservation.to_param }

        expect(response).to redirect_to(rate_reservation_path(reservation))
      end
    end

    context 'when an nonexistent reservation' do
      it 'redirects to new reservation' do
        get :confirm, { id: -1 }

        expect(response).to redirect_to(new_reservation_path)
      end
    end

  end

  describe 'PUT confirmation' do

    let(:reservation) { create(:reservation) }

    let(:new_attributes) { { first_name: 'Coyote', last_name: 'Acme', phone_number: '1234567890' } }

    context 'with valid params' do
      it 'updates the reservation' do
        expect {
          put :confirmation, { id: reservation.to_param, :reservation => new_attributes }
          reservation.reload
        }.to change(reservation, :first_name).to(new_attributes[:first_name])
      end

      it 'stores the user ip in the reservation' do
        allow(request).to receive(:remote_ip).and_return('190.165.218.56')

        expect {
          put :confirmation, { id: reservation.to_param, :reservation => new_attributes }
          reservation.reload
        }.to change(reservation, :user_ip).to('190.165.218.56')
      end

      it 'redirects to the confirmation customization' do
        put :confirmation, { id: reservation.to_param, :reservation => new_attributes }

        expect(response).to redirect_to(customize_reservation_path(reservation))
      end

      it 'adds success flash message' do
        put :confirmation, { id: reservation.to_param, :reservation => new_attributes }

        expect(flash[:notice]).to eq(I18n.t('reservation.confirmed'))
      end
    end

    context 'with invalid params' do
      before { new_attributes.delete(:last_name) }

      it 'assigns the reservation as @reservation' do
        put :confirmation, { id: reservation.to_param, :reservation => new_attributes }

        expect(assigns(:reservation)).to eq(reservation)
      end

      it 'keeps the given params' do
        put :confirmation, { id: reservation.to_param, :reservation => new_attributes }

        expect(assigns(:reservation).first_name).to eq(new_attributes[:first_name])
      end

      it 're-renders the confirm template' do
        put :confirmation, { id: reservation.to_param, :reservation => new_attributes }

        expect(response).to render_template(:confirm)
      end
    end

    context 'when an nonexistent reservation' do
      it 'redirects to new reservation' do
        put :confirmation, { id: -1, :reservation => new_attributes }

        expect(response).to redirect_to(new_reservation_path)
      end
    end

  end

  describe 'GET customize' do

    let(:reservation) { create(:reservation) }

    it 'assigns the reservation as @reservation' do
      get :customize, { id: reservation.to_param }

      expect(assigns(:reservation)).to eq(reservation)
    end

    context 'when an nonexistent reservation' do
      it 'redirects to new reservation' do
        get :customize, { id: -1 }

        expect(response).to redirect_to(new_reservation_path)
      end
    end

  end

  describe 'PUT customization' do

    let(:reservation) { create(:reservation, :confirmed) }

    let(:new_attributes) { { dark_wish: 'Catch the Road Runner' } }

    it 'updates the reservation' do
      expect {
        put :customization, { id: reservation.to_param, :reservation => new_attributes }
        reservation.reload
      }.to change(reservation, :dark_wish).to(new_attributes[:dark_wish])
    end

    it 'sends a confirmation email' do
      put :customization, { id: reservation.to_param, :reservation => new_attributes }

      subjects = ActionMailer::Base.deliveries.map(&:subject)

      expect(subjects).to include(I18n.t('mailers.reservation.completed'))
    end

    it 'sends a reservation scheduled email' do
      put :customization, { id: reservation.to_param, :reservation => new_attributes }

      subjects = ActionMailer::Base.deliveries.map(&:subject)

      expect(subjects).to include(I18n.t('mailers.reservation.scheduled'))
    end

    it 'redirects to a new reservation' do
      put :customization, { id: reservation.to_param, :reservation => new_attributes }

      expect(response).to redirect_to(new_reservation_path)
    end

    it 'adds success flash message' do
      put :customization, { id: reservation.to_param, :reservation => new_attributes }

      expect(flash[:notice]).to eq(I18n.t('reservation.completed'))
    end

    context 'when an nonexistent reservation' do
      it 'redirects to new reservation' do
        put :customization, { id: -1, :reservation => new_attributes }

        expect(response).to redirect_to(new_reservation_path)
      end
    end

  end

  describe 'GET rate' do

    let(:reservation) { create(:reservation) }

    it 'assigns the reservation as @reservation' do
      get :rate, { id: reservation.to_param }

      expect(assigns(:reservation)).to eq(reservation)
    end

    context 'when an nonexistent reservation' do
      it 'redirects to new reservation' do
        get :rate, { id: -1 }

        expect(response).to redirect_to(new_reservation_path)
      end
    end

  end

  describe 'PUT rating' do

    let(:reservation) { create(:reservation, :confirmed) }

    let(:new_attributes) { { rating: 3 } }

    context 'with valid params' do
      it 'updates the reservation' do
        expect {
          put :rating, { id: reservation.to_param, :reservation => new_attributes }
          reservation.reload
        }.to change(reservation, :rating).to(new_attributes[:rating])
      end

      it 'redirects to rate reservation' do
        put :rating, { id: reservation.to_param, :reservation => new_attributes }

        expect(response).to redirect_to(rate_reservation_path(reservation))
      end

      it 'adds success flash message' do
        put :rating, { id: reservation.to_param, :reservation => new_attributes }

        expect(flash[:notice]).to eq(I18n.t('reservation.rated'))
      end
    end

    context 'with invalid params' do
      it 'assigns the reservation as @reservation' do
        put :rating, { id: reservation.to_param }

        expect(assigns(:reservation)).to eq(reservation)
      end

      it 're-renders the rate template' do
        put :rating, { id: reservation.to_param }

        expect(response).to render_template(:rate)
      end
    end

    context 'when an nonexistent reservation' do
      it 'redirects to new reservation' do
        put :rating, { id: -1, :reservation => new_attributes }

        expect(response).to redirect_to(new_reservation_path)
      end
    end

  end

end