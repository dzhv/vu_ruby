require_relative('../../app/controllers/user_controller')
require_relative('../../app/user/contact_information')
require('securerandom')

describe UserController do
  let(:user_controller) { described_class.new }
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

  it 'allows user to get his profile' do
    user_id = user_controller.sign_up(user_data, login_data).id
    user = user_controller.get_user(user_id)
    expect(user).to have_attributes(
      id: user_id,
      contact_info: ContactInformation.new(user_data)
    )
  end
end
