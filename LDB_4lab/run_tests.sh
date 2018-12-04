#!/bin/bash
bundle install

echo 'RSpec...'
# sleep 2
bundle exec rspec

# sleep 5
echo 'Reek...'
# sleep 2
reek -c .reek.yml

# sleep 5
echo 'Rubocop...'
# sleep 2
rubocop

# sleep 5
echo 'Mutant...'
# sleep 2
# BudgetManager NotesManager Notification Order Project ProjectManager ProjectMember ProvidedMaterial Provider -> Search <- User UserManager WorkGroup WorkGroupManager WorkGroupMember WorkGroupTask Certificate Graph Task
bundle exec mutant --include app/models --use rspec BudgetManager NotesManager Notification Order Project ProjectManager ProjectMember ProvidedMaterial Provider Search User UserManager WorkGroup WorkGroupManager WorkGroupMember WorkGroupTask Certificate Graph Task -j 1
