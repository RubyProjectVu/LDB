#!/usr/bin/env bash

bundle install

# bundle exec mutant --include system --use rspec System*
# bundle exec mutant --include user --use rspec User*
# bundle exec mutant --include work_group --use rspec WorkGroup*
# bundle exec mutant --include project_merger --use rspec ProjectMerger*
# bundle exec mutant --include project --use rspec Project*
# bundle exec mutant --include project_data_checker --use rspec ProjectDataChecker*

bundle exec mutant --include lib --use rspec System User WorkGroup ProjectMerger Project ProjectDataChecker
# bundle exec rspec
# bundle exec rubocop
# bundle exec reek

