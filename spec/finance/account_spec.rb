require_relative '../spec_helper'
require_relative '../../app/finance/account'
require_relative '../../app/errors/errors'

describe Account do
  subject(:account) { Account.new }
  it 'new account is empty' do
    expect(account.balance).to equal(0)
  end

  context 'when insufficient funds' do
    it 'does not allow to withdraw' do
      balance_before_withdraw = 50
      account.add_money(balance_before_withdraw)
      withdraw_amount = 100

      expect {
        account.withdraw(withdraw_amount)
      }.to raise_error(Errors.insufficient_funds)
      expect(account.balance).to eq(balance_before_withdraw)
    end
  end
end
