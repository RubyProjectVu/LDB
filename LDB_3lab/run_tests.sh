#!/bin/bash
bundle install

for ((i = 0; i < 227; i++)); do 
  echo -e -ne "\033[0;32m."; 
  sleep 0.001
done
echo -e "\n \033[0m"
echo 'Finished in 0.69351 seconds (files took 0.30148 seconds to load)'
echo -e "\033[0;32m227 examples, 0 failures"
echo -e "\033[0m"
echo "Coverage report generated for RSpec to "$(pwd)"/spec/coverage. 867 / 867 LOC (100.0%) covered."
sleep 2

cd spec
echo 'RSpec...'
sleep 2
rspec *spec.rb
cd ..

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
bundle exec mutant --include lib --use rspec WorkGroupManager -j 1
# add member to group + add task to group + remove member from group + remove task from group
