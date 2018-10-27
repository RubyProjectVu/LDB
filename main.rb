class UIInitial
  attr_reader :currentuser

  def mainloop
    while true do
      case handle_initial_screen
      when false
        return
      when 'scflogin'
        handle_user_screen
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
    # email = prompt.ask('Email:')
    # pass = prompt.mask('Password:')
    usr = User.new(email: @currentuser = prompt.ask('Email:'))
    usr.password_set(prompt.mask('Password:'))
    # @currentuser = email
    return 'scflogin' if UserManager.new.login(usr.data_getter('email'))
    # needs password fetching as well
    false
  end

  def handle_user_screen
    cursor = TTY::Cursor
    prompt = TTY::Prompt.new

    while true do
      puts cursor.clear_screen
      puts cursor.move_to(0,0)
      puts Rainbow("LDB ").bright + Rainbow("--[#{@currentuser}]--\t").cyan + Rainbow('[' + Date.today.to_s + ']').green

      #list notes?
      #list projects
      #list chat?
      choice = prompt.select("Modules:", %w(Notes User\ management Project\ management Work\ group\ management Quit))
      case choice
      when 'Notes'
        subchoice = prompt.select("Note actions:", %w(Add\ note Back))
        case subchoice
        when 'Add note'
          puts cursor.clear_lines(2, :up)
          prompt.multiline("Edit:")
          prompt.yes?('Save this note?')

        when 'Back'
          next
        end

      when 'User management'
      when 'Quit'
        return
      end
    end
  end
end

ui = UIInitial.new
ui.mainloop
