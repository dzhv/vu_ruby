require_relative('../../app/authentication/auth_repository')
require_relative('../../app/authentication/login')

describe AuthRepository do
  let(:file_name) { 'test_login.yml' }
  let(:repository) { described_class.new(file_name) }
  let(:login) { Login.new(user_id, 'username', 'password') }
  let(:user_id) { '0' }

  before(:each) do
    File.delete(file_name) if File.exist?(file_name)
    repository.save_login(login)
  end

  it 'creates a file when it does not exist' do
    expect(File.exist?(file_name)).to be true
  end

  it 'saves data externally' do
    repository = described_class.new(file_name)
    expect(repository.get_login(user_id)).to eq(login)
  end
end
