class UsersController < ApplicationController
  def create
    if params.key?(:user)
      UserManager.new.register([params.fetch(:user).fetch(:name),
                                params.fetch(:user).fetch(:lname)],
                               params.fetch(:user).fetch(:email),
                               params.fetch(:user).fetch(:pass))
    end
  end

  def show
    # renders after deleting user
  end

  def update
    usr = User.find_by(email: current_user['email'])
    usr.name = params.fetch(:user).fetch(:name)
    usr.lname = params.fetch(:user).fetch(:lname)
    usr.password_set(params.fetch(:user).fetch(:pass))
  end

  def destroy
    UserManager.new.delete_user(current_user['email'])
  end

  def find_and_login
    @user = User.find_by(email: params.fetch(:user).fetch(:email))
    return true if sign_in(@user)

    false
  end

  def parse_login
    result = UserManager.new.login(params.fetch(:user).fetch(:email),
                                   params.fetch(:user).fetch(:pass))
    if result
      return false unless find_and_login
    end
  end
end
