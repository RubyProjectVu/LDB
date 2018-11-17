$user_manager = UserManager.new
$cursor = TTY::Cursor
$prompt = TTY::Prompt.new

# User management screen
def userm_submenu
  loop do
    print $cursor.move_to(0, 3) + $cursor.clear_screen_down
    STDOUT.flush
    subchoice = $prompt.select('User actions:', %w[Change\ password Delete\ current\ user
                                                           Back], cycle: true)
    case subchoice
    # Change user password
    when 'Change password'

      hash = $user_manager.to_hash(@currentuser)
      usr = User.new(name: hash[@currentuser].fetch('name'), last_name: hash[@currentuser].fetch('lname'), email: @currentuser)
      usr.password_set($prompt.mask("New password:"))
      $user_manager.users_pop(@currentuser)
      $user_manager.users_push(usr, usr.to_hash)

    # Delete this user
    when 'Delete current user'
      if $prompt.yes?(Rainbow('Delete this user? This cannot be undone.').red)

        $user_manager.delete_user(User.new(email: @currentuser))

        $prompt.ask(Rainbow('User deleted.').green, default: '[Enter]')
      end

    # Return from user management
    when 'Back'
      break
    end
  end
end
