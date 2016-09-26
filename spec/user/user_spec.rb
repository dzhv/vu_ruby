require_relative '../spec_helper'
require_relative '../../app/user/user'
require_relative '../../app/finance/account'
require_relative '../../app/auction/auction'
require_relative '../../app/auction/item'
require_relative '../../app/auction/auction_repository'
require('date')

describe User do
  subject(:user_data) {
    {
      name: 'name',
      surname: 'surname',
      email: 'email',
      address: 'address',
      tel_no: 'telephone'
    }
  }
  subject(:auction_repository) { AuctionRepository.new }
  subject(:auction_manager) { AuctionManager.new(auction_repository) }
  subject(:user_repository) { UserRepository.new }
  subject(:user_manager) { UserManager.new(auction_manager, user_repository) }
  subject(:user) { user_manager.sign_up user_data }

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