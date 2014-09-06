require 'rails_helper'

describe ReservationsController do

  let(:valid_attributes) { attributes_for(:reservation) }

  let(:invalid_attributes) { { :email => 'im_not_a_valid_email.org' }}

  describe 'GET new' do

    it 'assigns a new reservation as @reservation' do
      get :new

      expect(assigns(:reservation)).to be_a_new(Reservation)
    end

  end

  describe 'POST create' do

    context 'with valid params' do
      it 'creates a new Reservation' do
        expect {
          post :create, { :reservation => valid_attributes }
        }.to change(Reservation, :count).by(1)
      end

      it 'sends and message to the given email' do
        post :create, { :reservation => valid_attributes }

        email = ActionMailer::Base.deliveries.last

        expect(email.to).to include(valid_attributes[:email])
      end

      it 'redirects to a new reservation' do
        post :create, { :reservation => valid_attributes }

        expect(response).to redirect_to(new_reservation_path)
      end

      it 'adds success flash message' do
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

end