#!/usr/bin/env bash

bundle install

# Project ProjectManager User UserManager WorkGroup WorkGroupManager BudgetManager NotesManager Search
bundle exec mutant --include app --use rspec Project ProjectManager User UserManager WorkGroup WorkGroupManager BudgetManager NotesManager Search -j 1

