#!/bin/bash
bundle install

echo 'RSpec...'
sleep 2
bundle exec rspec

sleep 5
echo 'Reek...'
sleep 2
reek -c .reek.yml

sleep 5
echo 'Rubocop...'
sleep 2
rubocop

sleep 5
echo 'Mutant...'
sleep 2
# Project ProjectManager User UserManager WorkGroup WorkGroupManager BudgetManager NotesManager Search
bundle exec mutant --include app/models --use rspec User -j 1
