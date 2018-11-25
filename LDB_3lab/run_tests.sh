#!/bin/bash
bundle install

# Uzkomentuota del greicio

cd spec
echo 'RSpec...'
# sleep 2
rspec *spec.rb
cd ..

#sleep 5
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
# Project ProjectManager User UserManager WorkGroup WorkGroupManager BudgetManager NotesManager Search
bundle exec mutant --include lib --use rspec User UserManager -j 1
