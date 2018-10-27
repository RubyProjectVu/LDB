require_relative 'system'
require 'yaml'

# class defining user management
class UserManager
  def initialize
    @users = YAML.load_file('users.yml')
  end
  
  def register(user)
    @current_user = user.user_info
	
    mailing = @current_user.fetch('email')
    hash = { mailing => { 'name' => @current_user.fetch('name'.to_sym),
                          'lname' => @current_user.fetch('lname'.to_sym),
                          'pwd' => @current_user.fetch('pass'.to_sym)
                          'userID' => @current_user.fetch('userID'.to_sym) } }
    return true if users_push(mailing, hash)

    false
  end
  
  def login(user_to_login)
    return true unless [nil].include?(@users[user_to_login])

    false
  end

  def delete_user(user)
    users_pop(user.data_getter('email'))
  end

  def prepare_deletion
    return true unless ProjectManager.active_projects_present?

    false
  end
  
  def users_push(email, hash)
    return false if @users.key?(email)

    File.open('users.yml', 'a') { |fl| fl.write hash.to_yaml.sub('---', '') }
    true
  end

  def users_pop(email)
    @users.delete(email)
    File.open('users.yml', 'w') { |fl| fl.write @users.to_yaml.sub('---', '') }
    true
  end
end
