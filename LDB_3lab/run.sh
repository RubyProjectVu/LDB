#!/usr/bin/env bash

bundle install
bundle exec mutant --include lib --use rspec "System*"
# bundle exec rspec
# bundle exec rubocop
# bundle exec reek

