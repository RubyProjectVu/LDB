$notes_manager = NotesManager.new
$cursor = TTY::Cursor
$prompt = TTY::Prompt.new

# Notes management screen
def notes_submenu
  loop do
    print $cursor.move_to(0, 3) + $cursor.clear_screen_down
    STDOUT.flush
    subchoice = $prompt.select('Note actions:', %w[Add\ note Read\ note
                                                           Delete\ note Back], cycle: true)
    case subchoice
    # Create a new note
    when 'Add note'
      puts $cursor.clear_lines(2, :up)
      text = $prompt.multiline('Edit:')
      if $prompt.yes?('Save this note?')
        name = $prompt.ask('Note title: ')

        $notes_manager.save_note(@currentuser, name, text)

        $prompt.ask(Rainbow('Note created successfully.').green, default: '[Enter]')
      end
      print $cursor.move_to(0, 3) + $cursor.clear_screen_down
      STDOUT.flush

    # Review existing notes
    when 'Read note'
      subchoice = $prompt.select('Notes:', $notes_manager.list_notes.push('Back'), cycle: true)

      puts $cursor.move_to(0, 5) + $cursor.clear_screen_down
      if !subchoice.eql?('Back')

        puts $notes_manager.note_getter(subchoice)

        $prompt.select('', %w[Back])
        print $cursor.move_to(0, 3) + $cursor.clear_screen_down
        STDOUT.flush
      end

    # Remove a note
    when 'Delete note'
      subchoice = $prompt.select('Notes:', $notes_manager.list_notes.push('Back'), cycle: true)

      puts $cursor.move_to(0, 5) + $cursor.clear_screen_down
      if !subchoice.eql?('Back')
        if $prompt.yes?("Are you sure you want to delete #{subchoice}?")

          $notes_manager.delete_note(subchoice)

          $prompt.ask(Rainbow('Note deleted.').green, default: '[Enter]')
        end
      end

    # Return from notes management
    when 'Back'
      break
    end
  end
end