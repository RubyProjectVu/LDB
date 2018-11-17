$search = Search.new
$prompt = TTY::Prompt.new

def src_submenu
  choice = $prompt.select('', %w[Search\ for\ value Back], cycle: true)

  case choice
  # Initiates search among yml files for specified string
  when 'Search for value'
    objects = { 'Users': 'Users', 'Projects': 'Projects', 'Work groups': 'WorkGroups', 'Budgets': 'Budgets', 'Notes': 'Notes' }
    modules = $prompt.multi_select('Search where?', objects)

    puts $search.search_by_criteria(modules, $prompt.ask('Value:', default: ' '))

    $prompt.select('', %w[Back])

  # Back to previous menu
  when 'Back'
    return
  end
end
