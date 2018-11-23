
# Work group management screen
def wgm_submenu(currentuser)
  workgroup_manager = WorkGroupManager.new
  cursor = TTY::Cursor
  prompt = TTY::Prompt.new

  loop do
    print cursor.move_to(0, 3) + cursor.clear_screen_down
    STDOUT.flush
    subchoice = prompt.select('Work group actions:',
                                     %w[Set\ budget Add\ member Remove\ member Add\ task
                                        Remove\ task Delete\ group Create\ group Back],
                                       cycle: true, per_page: 8)

    case subchoice
    # Refine group's budget
    when 'Set budget'
      gr = prompt.select('', workgroup_manager.list_groups.push('Back'), cycle: true)

      if gr.eql?('Back')
        next
      end
      print Rainbow('Current budget: ').red

      group = workgroup_manager.load_group(gr.split(':').first)
      puts group.data_getter('budget')

      choice = prompt.select('', %w[Edit Back], cycle: true)
      if choice.eql?('Edit')

        group.data_setter('budget', prompt.ask('New value: ').to_f)
        workgroup_manager.save_group(group)

        prompt.ask(Rainbow('Budget updated.').green, default: '[Enter]')
      end

    when 'Add member'
      gr = prompt.select('', workgroup_manager.list_groups.push('Back'), cycle: true)

      if gr.eql?('Back')
        next
      end

      workgroup_manager.add_member_to_group(prompt.ask('Member mail:'), gr.split(':').first)

      prompt.ask(Rainbow('New member added.').green, default: '[Enter]')

    when 'Remove member'
      gr = prompt.select('', workgroup_manager.list_groups.push('Back'), cycle: true)

      if gr.eql?('Back')
        next
      end

      workgroup_manager.remove_member_from_group(prompt.ask('Member mail:'), gr.split(':').first)

      prompt.ask(Rainbow('Member removed.').green, default: '[Enter]')

    when 'Add task'
      gr = prompt.select('', workgroup_manager.list_groups.push('Back'), cycle: true)

      if gr.eql?('Back')
        next
      end

      workgroup_manager.add_task_to_group(prompt.ask('Task: ', default: ' '), gr.split(':').first)

      prompt.ask(Rainbow('New task added.').green, default: '[Enter]')

    when 'Remove task'
      gr = prompt.select('', workgroup_manager.list_groups.push('Back'), cycle: true)

      if gr.eql?('Back')
        next
      end

      workgroup_manager.remove_task_from_group(prompt.ask('Task: ', default: ' '), gr.split(':').first)

      prompt.ask(Rainbow('Task removed.').green, default: '[Enter]')

    when 'Create group'
      proj = prompt.select('', $project_manager.list_projects.push('Back'), cycle: true)

      if proj.eql?('Back')
        next
      end

      workgroup_manager.save_group(WorkGroup.new(prompt.ask('Identifier string: '),
                                                    proj.split(':').first,
                                                    prompt.ask('Name: ')))
      prompt.ask(Rainbow("Group created for project #{proj}.").green, default: '[Enter]')

    when 'Delete group'
      gr = prompt.select('', workgroup_manager.list_groups.push('Back'), cycle: true)

      if gr.eql?('Back')
        next
      end
      if prompt.yes?(Rainbow('Delete this group? This cannot be undone.').red)

        workgroup_manager.delete_group(gr.split(':').first)

        prompt.ask(Rainbow('Group deleted.').green, default: '[Enter]')
      end

    when 'Back'
      break
    end
  end
end