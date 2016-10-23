require_relative('../../app/controllers/authentication_controller')
require_relative('../../app/controllers/user_controller')
require('securerandom')

describe AuthController do
  let(:auth_controller) { described_class.new('test_logins.yml') }
  let(:user_controller) do
    UserController.new(
      'test_users.yml',
      'test_auctions.yml',
      'test_logins.yml'
    )
  end
  let(:user_data) do
    {
      name: 'name',
      surname: 'surname',
      email: 'email',
      tel_no: 'telephone'
    }
  end
  let(:login_data) do
    {
      username: SecureRandom.uuid,
      password: SecureRandom.uuid
    }
  end

  it 'allows user to login' do
    user = user_controller.sign_up(user_data, login_data)
    user_id = auth_controller.authenticate(
      login_data[:username],
      login_data[:password]
    )
    expect(user_id).to eq(user.id)
  end
end
