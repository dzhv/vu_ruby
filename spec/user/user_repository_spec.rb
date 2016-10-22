describe UserRepository do
  let(:file_name) { 'test_users.yml' }
  let(:repository) { described_class.new(file_name) }
  let(:user_data) do
    {
      name: 'name',
      surname: 'surname',
      email: 'email',
      tel_no: 'telephone'
    }
  end
  let(:user) { User.new('0', user_data) }

  before(:each) do
    File.delete(file_name)
    repository.save_user(user)
  end

  it 'creates a file when it does not exist' do
    expect(File.exist?(file_name)).to be true
  end

  it 'saves data externally' do
    repository = described_class.new(file_name)
    expect(repository.all_users).not_to be_empty
  end

  it 'does not override different user data' do
    other_user = User.new('1', user_data)
    repository.save_user(other_user)
    expect(repository.all_users).to match_array([user, other_user])
  end

  it 'overrides the same user data' do
    user_data[:name] = 'override_name'
    user_data[:surname] = 'override_surname'
    modified_user = User.new(user.id, user_data)
    repository.save_user(modified_user)
    expect(repository.all_users).to match_array([modified_user])
  end
end
