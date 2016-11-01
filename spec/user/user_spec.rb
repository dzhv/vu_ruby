require_relative '../spec_helper'
require_relative '../../app/user/user'
require_relative '../../app/finance/account'
require_relative '../../app/auction/auction'
require_relative '../../app/auction/item'
require_relative '../../app/auction/auction_repository'
require_relative '../../app/auction/auction_numerator'
require_relative '../../app/authentication/authentication'
require_relative '../../app/authentication/auth_repository'
require('date')

describe User do
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
  let(:auction_repository) { AuctionRepository.new('test_auctiions.yml') }
  let(:auction_numerator) { AuctionNumerator.new(auction_repository) }
  let(:auction_manager) do
    AuctionManager.new(auction_repository, auction_numerator)
  end
  let(:user_repository) { UserRepository.new('test_users.yml') }
  let(:authentication) do
    Authentication.new(AuthRepository.new('test_login.yml'))
  end
  let(:user_manager) do
    UserManager.new(auction_manager, user_repository, authentication)
  end
  let(:user) { user_manager.sign_up(user_data, login_data) }

  it 'is assigned an account' do
    expect(user.account).to be_a(Account)
  end

  it 'can add money to account' do
    balance_before_increase = user.account.balance
    amount = 100

    user.add_money(amount)
    expect(user.account.balance).to eq(balance_before_increase + amount)
  end

  it 'can withdraw money from account' do
    balance = 100
    user.add_money(balance)
    withdraw_amount = 50

    user.withdraw_money(withdraw_amount)
    expect(user.account.balance).to eq(balance - withdraw_amount)
  end
end
