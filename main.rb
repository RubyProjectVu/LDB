require 'rainbow'
require 'tty/cursor'
require 'tty/prompt'
require 'time'

#works on LINUX best
class UI
  def mainloop
    while true do
      case handle_login
      when false
        return
      end
    end
  end

  def handle_login
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
      #return sing_up
    when 'Login'
      #return login
    else
      puts cursor.clear_screen
      return false
    end
    end
end

ui = UI.new
ui.mainloop

