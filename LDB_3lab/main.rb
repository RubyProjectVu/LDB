# frozen_string_literal: true

require 'rainbow'
require 'tty/cursor'
require 'tty/prompt'
require 'time'
require_relative 'lib/user'
require_relative 'lib/user_manager'

#works on LINUX best

cursor = TTY::Cursor
prompt = TTY::Prompt.new
currentuser = nil

def notes_submenu
  subchoice = prompt.select("Note actions:", %w(Add\ note Back))
  case subchoice
  when 'Add note'
    puts cursor.clear_lines(2, :up)
    prompt.multiline("Edit:")
    prompt.yes?('Save this note?')

  when 'Back'
    return
  end
end

def choose
  choice = prompt.select("Modules:", %w(Notes User\ management Project\ management Work\ group\ management Quit))
  case choice
  when 'Notes'
    notes_submenu
    return
  when 'User management'
  when 'Quit'
    return false
  end
end

def user_menu
  while true do
    
  end
end

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
    puts cursor.clear_screen
    puts cursor.move_to(0, 0)
    puts Rainbow("LDB ").bright + Rainbow("--[#{currentuser}]--\t").cyan + Rainbow('[' + Date.today.to_s + ']').green
    break if choose == false
  end
end
