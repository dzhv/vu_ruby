require_relative('../../app/authentication/auth_repository')
require_relative('../../app/authentication/login')

describe AuthRepository do
  let(:prepared_file) { 'test_login_load.yml' }
  let(:output_file) { 'test_login_output.yml' }
  let(:login1) do
    Login.new(
      '60c376f6-3681-4a87-b070-be3fd9b280e4',
      'jonas',
      'e69e4398-1ec9-4bf4-811e-c934d2836ae2'
    )
  end
  let(:login2) do
    Login.new(
      '6be49d15-608d-479a-9180-25d568f530a0',
      'motiejus',
      'efdc969c-0332-4e99-b8a8-16281c08aa94'
    )
  end

  before(:each) do
    File.delete(output_file) if File.exist?(output_file)
  end

  it 'creates a file when it does not exist' do
    repository = described_class.new(output_file)
    repository.save_login(login1)
    expect(File.exist?(output_file)).to be true
  end

  it 'loads data from a file' do
    repository = described_class.new(prepared_file)
    expect(repository.all_logins).to match_array([login1, login2])
  end

  it 'saves data to a file' do
    repository = described_class.new(output_file)
    repository.save_login(login1)
    repository.save_login(login2)

    prepared_data = IO.read(prepared_file)
    actual_data = IO.read(output_file)
    expect(actual_data).to eq(prepared_data)
  end
end
