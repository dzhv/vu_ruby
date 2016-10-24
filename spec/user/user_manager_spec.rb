require_relative '../spec_helper'
require_relative '../../app/user/user_manager'
require_relative '../../app/user/user'
require_relative '../../app/user/user_repository'
require_relative '../../app/auction/auction_manager'
require_relative '../../app/auction/auction_repository'
require_relative '../../app/authentication/authentication'
require_relative '../../app/authentication/auth_repository'

describe UserManager do
  let(:auction_repository) { AuctionRepository.new('test_auctions.yml') }
  let(:auction_numerator) { AuctionNumerator.new(auction_repository) }
  let(:auction_manager) do
    AuctionManager.new(
      auction_repository,
      auction_repository
    )
  end
  let(:user_repository) { UserRepository.new('test_users.yml') }
  let(:user_manager) do
    described_class.new(auction_manager, user_repository, authentication)
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
      username: 'username',
      password: 'password'
    }
  end
  let(:authentication) do
    Authentication.new(AuthRepository.new('test_login.yml'))
  end

  it 'can sign up a user' do
    user = user_manager.sign_up(user_data, login_data)
    expect(user.contact_info).to have_attributes(
      name: eq(UserName.new(user_data)),
      email: user_data[:email],
      tel_no: user_data[:tel_no]
    )
  end

  it 'creates login data for user' do
    user = user_manager.sign_up(user_data, login_data)
    login = authentication.get_user_login(user.id)
    expect(login).to have_attributes(
      username: login_data[:username],
      password: be_hashed(login_data[:password]),
      user_id: user.id
    )
  end
end
