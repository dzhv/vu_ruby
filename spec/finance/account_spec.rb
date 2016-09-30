require_relative '../../app/finance/account'
require_relative '../../app/errors/errors'

describe Account do
  let(:account) { described_class.new }

  it 'new account is empty' do
    expect(account.balance).to equal(0)
  end

  context 'when insufficient funds' do
    let(:balance_before_withdraw) { 50 }
    let(:withdraw_amount) { 100 }
    before(:each) do
      account.add_money(balance_before_withdraw)
    end

    it 'does not allow to withdraw' do
      expect do
        account.withdraw(withdraw_amount)
      end.to raise_error(Errors.insufficient_funds)
    end
  end
end
