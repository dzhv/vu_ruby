require_relative '../spec_helper'
require_relative '../../app/user/user_manager'
require_relative '../../app/user/user'
require_relative '../../app/auction/auction_manager'
require_relative '../../app/auction/auction_repository'

describe UserManager do
  subject(:auction_repository) { AuctionRepository.new }
  subject(:auction_manager) { AuctionManager.new auction_repository }
  subject(:user_manager) { UserManager.new auction_manager }
  subject(:user_data) {
    {
      name: 'name',
      surname: 'surname',
      email: 'email',
      address: 'address',
      tel_no: 'telephone'
    }
  }

  it 'user can sign up' do
    user = user_manager.sign_up(user_data)
    expect(user).to be_a(User)
  end

  it 'sign up data is persisted' do
    user = user_manager.sign_up user_data
    expect(user.name).to equal(user_data[:name])
    expect(user.surname).to equal(user_data[:surname])
    expect(user.email).to equal(user_data[:email])
    expect(user.address).to equal(user_data[:address])
    expect(user.tel_no).to equal(user_data[:tel_no])
  end
end
