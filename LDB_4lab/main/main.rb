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
require_relative '../lib/work_group_manager'
require_relative '../lib/search'

cursor = TTY::Cursor
prompt = TTY::Prompt.new
@currentuser = nil

# Notes management screen
def notes_submenu
  cursor = TTY::Cursor
  loop do
    print TTY::Cursor.move_to(0, 3) + TTY::Cursor.clear_screen_down
    STDOUT.flush
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
    print TTY::Cursor.move_to(0, 3) + TTY::Cursor.clear_screen_down
    STDOUT.flush
    subchoice = TTY::Prompt.new.select('User actions:', %w[Change\ password Delete\ current\ user
                                                           Back], cycle: true)
    case subchoice
    # Change user password
    when 'Change password'
      hash = UserManager.new.to_hash(@currentuser)
      usr = User.new(name: hash[@currentuser].fetch('name'), last_name: hash[@currentuser].fetch('lname'), email: @currentuser)
      usr.password_set(TTY::Prompt.new.mask("New password:"))
      UserManager.new.users_pop(@currentuser)
      UserManager.new.users_push(usr, usr.to_hash)

    # Delete this user
    when 'Delete current user'
      if TTY::Prompt.new.yes?(Rainbow('Delete this user? This cannot be undone.').red)
        UserManager.new.delete_user(User.new(email: @currentuser))
        TTY::Prompt.new.ask(Rainbow('User deleted.').green, default: '[Enter]')
      end

    # Return from user management
    when 'Back'
      break
    end
  end
end

# Project management screen
def projm_submenu
  loop do
    print TTY::Cursor.move_to(0, 3) + TTY::Cursor.clear_screen_down
    STDOUT.flush
    subchoice = TTY::Prompt.new.select('Project actions:',
                                     %w[Set\ budget Negative\ budgets Add\ member Remove\ member
                                        Set\ status Delete\ project Create\ project Back],
                                       cycle: true, per_page: 8)
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
        BudgetManager.new.budgets_setter(proj.split(':').first, TTY::Prompt.new.ask('New value: ').to_f)
        TTY::Prompt.new.ask(Rainbow('Budget updated.').green, default: '[Enter]')
      end

    # Review projects with negative budget
    when 'Negative budgets'
      puts BudgetManager.new.check_negative
      TTY::Prompt.new.select('', %w[Back])

    # Adds a new member to project
    when 'Add member'
      proj = TTY::Prompt.new.select('', ProjectManager.new.list_projects.push('Back'), cycle: true)
      if proj.eql?('Back')
        next
      end
      project = ProjectManager.new.load_project(proj.split(':').first)
      project.add_member(TTY::Prompt.new.ask('Member mail:'))
      ProjectManager.new.delete_project(Project.new(num: proj.split(':').first))
      ProjectManager.new.save_project(project)
      TTY::Prompt.new.ask(Rainbow('New member added.').green, default: '[Enter]')

    # Removes a member from project
    when 'Remove member'
      proj = TTY::Prompt.new.select('', ProjectManager.new.list_projects.push('Back'), cycle: true)
      if proj.eql?('Back')
        next
      end
      project = ProjectManager.new.load_project(proj.split(':').first)
      project.remove_member(TTY::Prompt.new.ask('Member mail:'))
      ProjectManager.new.delete_project(Project.new(num: proj.split(':').first))
      ProjectManager.new.save_project(project)
      TTY::Prompt.new.ask(Rainbow('Member removed.').green, default: '[Enter]')

    # Refine project's status
    when 'Set status'
      proj = TTY::Prompt.new.select('', ProjectManager.new.list_projects.push('Back'), cycle: true)
      if proj.eql?('Back')
        next
      end
      project = ProjectManager.new.load_project(proj.split(':').first)
      print Rainbow('Current status: ').red
      puts project.parm_project_status
      choice = TTY::Prompt.new.select('', %w[Edit Back], cycle: true)
      if choice.eql?('Edit')
        if project.parm_project_status(TTY::Prompt.new.ask('New status: ', default: ' '))
          ProjectManager.new.delete_project(Project.new(num: proj.split(':').first))
          ProjectManager.new.save_project(project)
          TTY::Prompt.new.ask(Rainbow('Status updated').green, default: '[Enter]')
        else
          TTY::Prompt.new.warn('Set status as one of: Proposed, Suspended, Postponed, Cancelled, In progress')
          TTY::Prompt.new.ask(Rainbow('Return to previous menu').yellow, default: '[Enter]')
        end
      end

    # Removes a project
    when 'Delete project'
      proj = TTY::Prompt.new.select('', ProjectManager.new.list_projects.push('Back'), cycle: true)
      if proj.eql?('Back')
        next
      end
      if TTY::Prompt.new.yes?(Rainbow('Delete this project? This cannot be undone.').red)
        ProjectManager.new.delete_project(Project.new(num: proj.split(':').first))
        TTY::Prompt.new.ask(Rainbow('Project deleted.').green, default: '[Enter]')
      end

    # Creates a project
    when 'Create project'
      ProjectManager.new.save_project(Project.new(project_name: TTY::Prompt.new.ask('Name: '),
                                                  manager: TTY::Prompt.new.ask('Manager: '),
                                                  num: id = TTY::Prompt.new.ask('Identifier string: ')))
      BudgetManager.new.budgets_setter(id, 0)
      TTY::Prompt.new.ask(Rainbow('Project created').green, default: '[Enter]')

    # Return from project management
    when 'Back'
      break
    end
  end
end

# Work group management screen
def wgm_submenu
  loop do
    print TTY::Cursor.move_to(0, 3) + TTY::Cursor.clear_screen_down
    STDOUT.flush
    subchoice = TTY::Prompt.new.select('Work group actions:',
                                     %w[Set\ budget Add\ member Remove\ member Add\ task
                                        Remove\ task Delete\ group Create\ group Back],
                                       cycle: true, per_page: 8)

    case subchoice
    # Refine group's budget
    when 'Set budget'
      gr = TTY::Prompt.new.select('', WorkGroupManager.new.list_groups.push('Back'), cycle: true)
      if gr.eql?('Back')
        next
      end
      print Rainbow('Current budget: ').red
      group = WorkGroupManager.new.load_group(gr.split(':').first)
      puts group.data_getter('budget')
      choice = TTY::Prompt.new.select('', %w[Edit Back], cycle: true)
      if choice.eql?('Edit')
        group.data_setter('budget', TTY::Prompt.new.ask('New value: ').to_f)
        WorkGroupManager.new.save_group(group)
        TTY::Prompt.new.ask(Rainbow('Budget updated.').green, default: '[Enter]')
      end

    when 'Add member'
      gr = TTY::Prompt.new.select('', WorkGroupManager.new.list_groups.push('Back'), cycle: true)
      if gr.eql?('Back')
        next
      end
      group = WorkGroupManager.new.load_group(gr.split(':').first)
      group.add_group_member(User.new(email: TTY::Prompt.new.ask('Member mail:')))
      WorkGroupManager.new.save_group(group)
      TTY::Prompt.new.ask(Rainbow('New member added.').green, default: '[Enter]')

    when 'Remove member'
      gr = TTY::Prompt.new.select('', WorkGroupManager.new.list_groups.push('Back'), cycle: true)
      if gr.eql?('Back')
        next
      end
      group = WorkGroupManager.new.load_group(gr.split(':').first)
      group.remove_group_member(User.new(email: TTY::Prompt.new.ask('Member mail:')))
      WorkGroupManager.new.save_group(group)
      TTY::Prompt.new.ask(Rainbow('Member removed.').green, default: '[Enter]')

    when 'Add task'
      gr = TTY::Prompt.new.select('', WorkGroupManager.new.list_groups.push('Back'), cycle: true)
      if gr.eql?('Back')
        next
      end
      group = WorkGroupManager.new.load_group(gr.split(':').first)
      group.add_group_task(TTY::Prompt.new.ask('Task: ', default: ' '))
      WorkGroupManager.new.save_group(group)
      TTY::Prompt.new.ask(Rainbow('New task added.').green, default: '[Enter]')

    when 'Remove task'
      gr = TTY::Prompt.new.select('', WorkGroupManager.new.list_groups.push('Back'), cycle: true)
      if gr.eql?('Back')
        next
      end
      group = WorkGroupManager.new.load_group(gr.split(':').first)
      group.remove_group_task(TTY::Prompt.new.ask('Task: ', default: ' '))
      WorkGroupManager.new.save_group(group)
      TTY::Prompt.new.ask(Rainbow('Task removed.').green, default: '[Enter]')

    when 'Create group'
      proj = TTY::Prompt.new.select('', ProjectManager.new.list_projects.push('Back'), cycle: true)
      if proj.eql?('Back')
        next
      end
      WorkGroupManager.new.save_group(WorkGroup.new(TTY::Prompt.new.ask('Identifier string: '),
                                                    proj.split(':').first,
                                                    TTY::Prompt.new.ask('Name: ')))
      TTY::Prompt.new.ask(Rainbow("Group created for project #{proj}.").green, default: '[Enter]')

    when 'Delete group'
      gr = TTY::Prompt.new.select('', WorkGroupManager.new.list_groups.push('Back'), cycle: true)
      if gr.eql?('Back')
        next
      end
      if TTY::Prompt.new.yes?(Rainbow('Delete this group? This cannot be undone.').red)
        WorkGroupManager.new.delete_group(gr.split(':').first)
        TTY::Prompt.new.ask(Rainbow('Group deleted.').green, default: '[Enter]')
      end

    when 'Back'
      break
    end
  end
end

def src_submenu
  choice = TTY::Prompt.new.select('', %w[Search\ for\ value Back], cycle: true)

  case choice
  # Initiates search among yml files for specified string
  when 'Search for value'
    objects = { 'Users': 'Users', 'Projects': 'Projects', 'Work groups': 'WorkGroups', 'Budgets': 'Budgets', 'Notes': 'Notes' }
    modules = TTY::Prompt.new.multi_select('Search where?', objects)
    puts Search.new.search_by_criteria(modules, TTY::Prompt.new.ask('Value:', default: ' '))
    TTY::Prompt.new.select('', %w[Back])

  # Back to previous menu
  when 'Back'
    return
  end
end

@usr_hash = { 'Search' => method(:src_submenu),
              'Notes' => method(:notes_submenu),
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

    choice = prompt.select('Modules:', %w[Search Notes User\ management Project\ management
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
      prompt.ask(Rainbow('Return to previous menu').yellow, default: '[Enter]')
    end

  # Terminate LDB
  when 'Exit'
    puts cursor.clear_screen
    break
  end
end
