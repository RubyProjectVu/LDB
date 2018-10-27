require 'rainbow'
require 'tty/cursor'
require 'tty/prompt'
require 'time'
require_relative 'lib/user'
require_relative 'lib/user_manager'

#works on LINUX best
class UI
  def mainloop
    while true do
      case handle_initial_screen
      when false
        return
      when 'scflogin'
        # logged in here - take to userpage
        return
      end
    end
  end

  def handle_initial_screen
    cursor = TTY::Cursor
    prompt = TTY::Prompt.new
    puts cursor.clear_screen

    puts cursor.move_to(0,0)
    puts Rainbow("LDB\t").bright + Rainbow('[' + Date.today.to_s + ']').green

    choice = prompt.select("", %w(Sign\ up Login Exit))
    puts cursor.clear_lines(2, :up)

    case choice
    when 'Sign up'
      puts cursor.clear_screen
      prompt.ask('Email:')
      prompt.mask('Password:')
      prompt.mask('Repeat password:')
      handle_sign_up
    when 'Login'
      return handle_login
    else
      puts cursor.clear_screen
      return false
    end
    end

  def handle_login
    cursor = TTY::Cursor
    prompt = TTY::Prompt.new
    puts cursor.clear_screen
    email = prompt.ask('Email:')
    pass = prompt.mask('Password:')
    usr = User.new(email: email)
    usr.password_set(pass)
    return 'scflogin' if UserManager.new.login(usr.data_getter('email'))
    # needs password fetching as well
    false
  end
end

ui = UI.new
ui.mainloop
