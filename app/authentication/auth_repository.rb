# Handles login storage
class AuthRepository
  def initialize(file_name)
    @file_name = file_name
  end

  def get_login(user_id)
    all_logins.find { |login| login.user_id == user_id }
  end

  def save_login(login)
    logins = all_logins
    logins.delete(login)
    File.open(@file_name, 'w') do |file|
      file.write(logins.push(login).to_yaml)
    end
    login
  end

  def all_logins
    ensure_file_exists
    File.open(@file_name, 'r') do |file|
      YAML.load(file)
    end || []
  end

  def ensure_file_exists
    File.open(@file_name, 'w') {} unless File.exist?(@file_name)
  end
end
