require_relative '../spec_helper'
require_relative('../../app/authentication/auth_repository')
require_relative('../../app/authentication/authentication')
require 'securerandom'

describe Authentication do
  let(:file_name) { 'test_login.yml' }
  let(:auth_repository) { AuthRepository.new(file_name) }
  let(:authentication) { described_class.new(auth_repository) }
  let(:username) { SecureRandom.uuid }
  let(:password) { SecureRandom.uuid }
  let(:user_id) { SecureRandom.uuid }

  before(:each) do
    authentication.create_login(user_id, username, password)
  end

  it 'stores encrypted passwords' do
    login = authentication.get_user_login(user_id)
    expect(login.password).to be_hashed(password)
  end

  context 'when login is correct' do
    it 'authenticates the user' do
      expect(authentication.authenticate(username, password)).to eq(user_id)
    end
  end

  context 'when login is incorrect' do
    it 'does not authenticate the user' do
      expect do
        authentication.authenticate(username, 'wrongpassword')
      end.to raise_error(Errors::WrongCredentialsError)
    end
  end
end
