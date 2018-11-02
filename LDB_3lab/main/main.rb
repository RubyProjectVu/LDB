# frozen_string_literal: true

require 'rainbow'
require 'tty/cursor'
require 'tty/prompt'
require 'time'
require_relative '../lib/user'
require_relative '../lib/user_manager'
require_relative '../lib/notes_manager'
require_relative '../lib/project_manager'
require_relative '../lib/budget_manager'

cursor = TTY::Cursor
prompt = TTY::Prompt.new
@currentuser = nil

# Notes management screen
def notes_submenu
  cursor = TTY::Cursor
  loop do
    subchoice = TTY::Prompt.new.select('Note actions:', %w[Add\ note Read\ note 
                                                           Delete\ note Back], cycle: true)
    case subchoice
    # Create a new note
    when 'Add note'
      puts cursor.clear_lines(2, :up)
      text = TTY::Prompt.new.multiline('Edit:')
      if TTY::Prompt.new.yes?('Save this note?')
        name = TTY::Prompt.new.ask('Note title: ')
        NotesManager.new.save_note(@currentuser, name, text)
        TTY::Prompt.new.ask(Rainbow('Note created successfully.').green, default: '[Enter]')
      end
      print cursor.move_to(0, 3) + cursor.clear_screen_down
      STDOUT.flush

    # Review existing notes
    when 'Read note'
      subchoice = TTY::Prompt.new.select('Notes:', NotesManager.new.list_notes.push('Back'), cycle: true)
      puts cursor.move_to(0, 5) + cursor.clear_screen_down
      if !subchoice.eql?('Back')
        puts NotesManager.new.note_getter(subchoice)
        TTY::Prompt.new.select('', %w[Back])
        print cursor.move_to(0, 3) + cursor.clear_screen_down
        STDOUT.flush
      end

    # Remove a note
    when 'Delete note'
      subchoice = TTY::Prompt.new.select('Notes:', NotesManager.new.list_notes.push('Back'), cycle: true)
      puts cursor.move_to(0, 5) + cursor.clear_screen_down
      if !subchoice.eql?('Back')
        if TTY::Prompt.new.yes?("Are you sure you want to delete #{subchoice}?")
          NotesManager.new.delete_note(subchoice)
          TTY::Prompt.new.ask(Rainbow('Note deleted.').green, default: '[Enter]')
        end
      end

    # Return from notes management
    when 'Back'
      break
    end
  end
end

# User management screen
def userm_submenu
  loop do
    subchoice = TTY::Prompt.new.select('User actions:', %w[Change\ password Back], cycle: true)
    case subchoice
    # Change user password
    when 'Change password'
      puts TTY::Cursor.clear_lines(2, :up)
      hash = UserManager.new.to_hash(@currentuser)
      usr = User.new(name: hash[@currentuser].fetch('name'), last_name: hash[@currentuser].fetch('lname'), email: @currentuser)
      usr.password_set(TTY::Prompt.new.mask("New password:"))
      UserManager.new.users_pop(@currentuser)
      UserManager.new.users_push(usr, usr.to_hash)

    # Return from user management
    when 'Back'
      break
    end
  end
end

# Project management screen
def projm_submenu
  loop do
    subchoice = TTY::Prompt.new.select('Project actions:',
                                     %w[Set\ budget Negative\ budgets Back], cycle: true)
    case subchoice
    # Refine project's budget
    when 'Set budget'
      proj = TTY::Prompt.new.select('', ProjectManager.new.list_projects.push('Back'), cycle: true)
      if proj.eql?('Back')
        next
      end
      print Rainbow('Current budget: ').red
      puts BudgetManager.new.budgets_getter(proj.split(':').first)
      choice = TTY::Prompt.new.select('', %w[Edit Back], cycle: true)
      if choice.eql?('Edit')
        TTY::Prompt.new.ask('New value: ')
      end

    # Review projects with negative budget
    when 'Negative budgets'
      puts BudgetManager.new.check_negative
      TTY::Prompt.new.select('', %w[Back])

    # Return from project management
    when 'Back'
      break
    end
  end
end

# Work group management screen
def wgm_submenu
  puts ''
end

@usr_hash = { 'Notes' => method(:notes_submenu),
              'User management' => method(:userm_submenu),
              'Project management' => method(:projm_submenu),
              'Work group management' => method(:wgm_submenu) }

# Modules menu screen
def user_menu(currentuser)
  cursor = TTY::Cursor
  prompt = TTY::Prompt.new
  loop do
    puts cursor.clear_screen + cursor.move_to(0, 0)
    puts Rainbow("LDB\t").green + Rainbow("--[#{currentuser}]--\t").cyan + Rainbow("[ #{Date.today} ]").green

    choice = prompt.select('Modules:', %w[Notes User\ management Project\ management
    Work\ group\ management Quit], cycle: true)
    break if choice.eql?('Quit')
    @usr_hash[choice].call
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

  choice = prompt.select('', %w[Sign\ up Login Exit], cycle: true)
  puts cursor.clear_lines(2, :up)

  case choice
  # Create a new user
  when 'Sign up'
    puts cursor.clear_screen
    if user_setup(prompt.ask('Email:'), prompt.mask('Password:'))
      prompt.ask(Rainbow('User created successfully. You may now login').green, default: '[Enter]') 
    else
      prompt.warn('Could not create a new account')
      prompt.ask(Rainbow('Return to previous menu').yellow, default: '[Enter]')
    end

  # Login with existing credentials
  when 'Login'
    puts cursor.clear_screen
    usr = User.new(email: @currentuser = prompt.ask('Email:'))
    usr.password_set(prompt.mask('Password:'))
    if UserManager.new.login(usr.data_getter('email'))
      user_menu(@currentuser)
    else
      prompt.warn('Could not login with specified credentials')
      prompt.ask('', default: 'Return to previous menu')
    end

  # Terminate LDB
  when 'Exit'
    puts cursor.clear_screen
    break
  end
end
