class UsersController < ApplicationController
  def create
    if params.key?(:user)
      hash = params.fetch(:user)
      UserManager.new.register([hash.fetch(:name),
                                hash.fetch(:lname)],
                               hash.fetch(:email),
                               hash.fetch(:pass))
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
    if @user
      sign_in(@user)
      return true
    end
    false
  end

  def parse_login
    result = UserManager.new.login(params.fetch(:user).fetch(:email),
                                   params.fetch(:user).fetch(:pass))
    if result
      false unless find_and_login
    end
  end
end
