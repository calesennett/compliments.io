require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }

  describe 'GET #edit' do
    context 'when user not logged in' do
      it 'redirects to home page' do
        get :edit, params: {id: user.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when incorrect session id' do
      it 'redirects to home page' do
        get :edit, params: {id: user.id}, session: {digits_id: 1111}

        expect(user.digits_id).to_not eq(session[:digits_id])
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is logged in' do
      it 'renders edit template' do
        get :edit, params: {id: user.id}, session: {digits_id: user.digits_id}
        expect(response).to be_success
      end
    end
  end

  describe 'POST #update' do
    context 'without correct digits_id' do
      it 'does not save user information' do
        post :update, params: {id: user.id, user: {frequency: 'monthly'}}, session: {digits_id: 1111}

        expect(response).to redirect_to(root_path)
        expect(user.reload.frequency).to eq('daily')
      end
    end

    context 'when valid frequency' do
      it 'successfully updates user information' do
        post :update, params: {id: user.id, user: {frequency: 'monthly'}}, session: {digits_id: user.digits_id}

        expect(response).to redirect_to(edit_user_path(user))
        expect(user.reload.frequency).to eq('monthly')
      end
    end

    context 'when invalid frequency' do
      it 'does not update user with invalid frequency' do
        post :update, params: {id: user.id, user: {frequency: 'never'}}, session: {digits_id: user.digits_id}

        expect(response).to redirect_to(edit_user_path(user))
        expect(user.reload.frequency).to eq('daily')
      end
    end
  end
end
