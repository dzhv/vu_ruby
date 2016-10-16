require 'yaml'

# User storage class
class UserRepository
  def initialize(file_name)
    @file_name = file_name
  end

  def save_user(user)
    users = all_users
    users.delete(user)
    File.open(@file_name, 'w') { |file| file.write(users.push(user).to_yaml) }
  end

  def get_user(user_id)
    all_users.find { |user| user.id == user_id }
  end

  def all_users
    ensure_file_exists
    File.open(@file_name, 'r') do |file|
      YAML.load(file)
    end || []
  end

  def ensure_file_exists
    File.open(@file_name, 'w') {} unless File.exist?(@file_name)
  end
end
