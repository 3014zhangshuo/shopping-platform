require 'rails_helper'

describe UsersController, type: :controller do

  context 'signup' do
    it 'should failed' do
      post :create, params: { user: { email: 'test@tv.com' } }
      expect(response).to render_template('new')
    end

    it 'should success' do
      post :create, params: { user:
        {
          email: 'test@tv.com',
          password: '111111',
          password_confirmation: '111111'
        }
      }
      expect(response).to redirect_to(new_session_path)
    end
  end
end
