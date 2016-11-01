describe UserRepository do
  let(:prepared_file) { 'test_user_load.yml' }
  let(:output_file) { 'test_user_output.yml' }
  let(:user1_data) do
    {
      id: '126cf668-2148-4560-b9a7-69447807e7ab',
      name: 'Jonas',
      surname: 'Biliunas',
      email: 'jonas@gmail.com',
      tel_no: '8600043421',
      balance: 250
    }
  end
  let(:user1) do
    user = User.new(user1_data[:id], user1_data)
    user.add_money(user1_data[:balance])
    user
  end
  let(:user2_data) do
    {
      id: '492ad638-0548-40b0-b9a7-69597807e7ab',
      name: 'Motiejus',
      surname: 'Valancius',
      email: 'motiejus@gmail.com',
      tel_no: '8612393954',
      balance: 494
    }
  end
  let(:user2) do
    user = User.new(user2_data[:id], user2_data)
    user.add_money(user2_data[:balance])
    user
  end
  before(:each) do
    File.delete(output_file) if File.exist?(output_file)
  end

  it 'creates a file when it does not exist' do
    repository = described_class.new(output_file)
    repository.save_user(user1)
    expect(File.exist?(prepared_file)).to be true
  end

  it 'loads data from a file' do
    repository = described_class.new(prepared_file)
    expect(repository.all_users).to match_array([user1, user2])
  end

  it 'saves data to a file' do
    repository = described_class.new(output_file)
    repository.save_user(user1)
    repository.save_user(user2)

    prepared_data = IO.read(prepared_file)
    actual_data = IO.read(output_file)
    expect(actual_data).to eq(prepared_data)
  end
end
