#!/usr/bin/env bash

bundle install


bundle exec mutant --include lib --use rspec Project ProjectManager User UserManager WorkGroup WorkGroupManager
# bundle exec rspec
# bundle exec rubocop
# bundle exec reek

