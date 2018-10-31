# frozen_string_literal: true

require 'rainbow'
require 'tty/cursor'
require 'tty/prompt'
require 'time'
require_relative '../lib/user'
require_relative '../lib/user_manager'

cursor = TTY::Cursor
prompt = TTY::Prompt.new
@currentuser = nil
@usr_module = %w[Notes User\ management
                 Project\ management
                 Work\ group\ management Quit]

def notes_submenu
  subchoice = TTY::Prompt.new.select('Note actions:', %w[Add\ note Back])
  case subchoice
  when 'Add note'
    puts TTY::Cursor.clear_lines(2, :up)
    TTY::Prompt.new.multiline('Edit:')
    return unless TTY::Prompt.new.yes?('Save this note?')
  end
end

def userm_submenu
  subchoice = TTY::Prompt.new.select('User actions:', %w[Change\ password Back])
  case subchoice
  when 'Change password'
    puts TTY::Cursor.clear_lines(2, :up)
    hash = UserManager.new.to_hash(@currentuser)
    usr = User.new(name: hash[@currentuser].fetch('name'), last_name: hash[@currentuser].fetch('lname'), email: @currentuser)
    usr.password_set(TTY::Prompt.new.mask("New password:"))
    UserManager.new.users_pop(@currentuser)
    UserManager.new.users_push(usr, usr.to_hash)
  end
end

def list_projects
  puts ProjectManager.new.list_projects
end

def projm_submenu
  subchoice = TTY::Prompt.new.select('Project actions:',
                                     %w[List\ projects Back])
  case subchoice
  when 'List projects'
    puts list_projects
    TTY::Prompt.new.select('', %w[Back])
  end
end

@usr_hash = { 'Notes' => method(:notes_submenu),
              'User management' => method(:userm_submenu),
              'Project management' => method(:projm_submenu) }

# Calls method on choice
def user_choose
  prompt = TTY::Prompt.new
  choice = prompt.select('Modules:', @usr_module)
  return false if choice.eql?('Quit')
  @usr_hash[choice].call
end

# Handles user module menu loop
def user_menu(currentuser)
  cursor = TTY::Cursor
  prompt = TTY::Prompt.new
  loop do
    puts cursor.clear_screen + cursor.move_to(0, 0)
    prompt.ok("LDB --[#{currentuser}]--\t [ #{Date.today} ]")
    break if user_choose == false
  end
end

# New user creation
def user_setup(mail, pass)
  usr = User.new(name: '', last_name: '', email: mail)
  usr.password_set(pass)
  return UserManager.new.register(usr)
end

# Initial screen
loop do
  puts cursor.clear_screen
  puts cursor.move_to(0, 0)
  puts Rainbow("LDB\t").bright + Rainbow('[' + Date.today.to_s + ']').green

  choice = prompt.select('', %w[Sign\ up Login Exit])
  puts cursor.clear_lines(2, :up)

  case choice
  when 'Sign up'
    puts cursor.clear_screen
    if user_setup(prompt.ask('Email:'), prompt.mask('Password:'))
      prompt.ask(Rainbow('User created successfully. You may now login').green, default: '[Enter]') 
    else
      prompt.warn('Could not create a new account')
      prompt.ask('', default: 'Return to previous menu')
    end

  when 'Login'
    puts cursor.clear_screen
    usr = User.new(email: @currentuser = prompt.ask('Email:'))
    usr.password_set(prompt.mask('Password:'))
    if UserManager.new.login(usr.data_getter('email'))
      user_menu
    else
      prompt.warn('Could not login with specified credentials')
      prompt.ask('', default: 'Return to previous menu')
    end
  when 'Exit'
    puts cursor.clear_screen
    break
  end
end
