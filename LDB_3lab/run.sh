#!/usr/bin/env bash

bundle install

# Project ProjectManager User UserManager WorkGroup WorkGroupManager BudgetManager NotesManager
bundle exec mutant --include lib --use rspec Project ProjectManager User UserManager WorkGroup WorkGroupManager BudgetManager NotesManager
# bundle exec rspec
# bundle exec rubocop
# bundle exec reek

