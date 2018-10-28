# frozen_string_literal: true

require 'rainbow'
require 'tty/cursor'
require 'tty/prompt'
require 'time'
require_relative 'lib/user'
require_relative 'lib/user_manager'
# works on LINUX best

cursor = TTY::Cursor
prompt = TTY::Prompt.new
currentuser = nil
@usr_module = %w(Notes User\ management
                 Project\ management
                 Work\ group\ management Quit)


def notes_submenu
  subchoice = TTY::Prompt.new.select("Note actions:", %w(Add\ note Back))
  case subchoice
  when 'Add note'
    puts TTY::Cursor.clear_lines(2, :up)
    TTY::Prompt.new.multiline("Edit:")
    TTY::Prompt.new.yes?('Save this note?')

  when 'Back'
    return
  end
end

def userm_submenu
  
end

@usr_hash = { 'Notes' => method(:notes_submenu),
              'User management' => method(:userm_submenu) }

# Calls method on choice
def user_choose
  prompt = TTY::Prompt.new
  choice = prompt.select("Modules:", @usr_module)
  return false if choice.eql?('Quit')
  @usr_hash[choice].call
end

# Handles user module menu loop
def user_menu(currentuser)
  cursor = TTY::Cursor
  prompt = TTY::Prompt.new
  while true do
    puts cursor.clear_screen + cursor.move_to(0, 0)
    prompt.ok("LDB --[#{currentuser}]--\t [ #{Date.today} ]")
    break if user_choose == false
  end
end

# Main flow
while true do
  puts cursor.clear_screen
  puts cursor.move_to(0,0)
  puts Rainbow("LDB\t").bright + Rainbow('[' + Date.today.to_s + ']').green

  choice = prompt.select('', %w(Sign\ up Login Exit))
  puts cursor.clear_lines(2, :up)
  outcome = nil

  case choice
  when 'Sign up'
    puts cursor.clear_screen
    prompt.ask('Email:')
    prompt.mask('Password:')
    prompt.mask('Repeat password:') 
    # handle_sign_up
  when 'Login'
    puts cursor.clear_screen
    usr = User.new(email: currentuser = prompt.ask('Email:'))
    usr.password_set(prompt.mask('Password:'))
    outcome = false
    outcome = 'scflogin' if UserManager.new.login(usr.data_getter('email'))
    # needs password fetching as well
  when 'Exit'
    puts cursor.clear_screen
    break
  end

  if outcome.chomp.eql?('scflogin')
    user_menu(currentuser)
  end
end
