# Some docs here
class UserDataChecker
  attr_reader :user_file
  attr_reader :state

  def initialize
    @user_file = 'users.txt'
    @state = true
  end

  def register(user_to_register)
    if File.file?(@user_file)
      # user_file = File.read(@user_file)
      users = users_getter
      users.each do |user|
        user_data = user.split(',')
        return false if user_data[2].match(user_to_register.email_getter)
      end
    end
    # save_registered_user(user_to_register)
    true
  end

  def users_getter
    user_file = File.read(@user_file)
    user_file.split(';')
  end
end
