# frozen_string_literal: true

require_relative 'work_group'
require_relative 'work_group_manager'

wg = WorkGroup.new(453, 3_324, 'Test', ['jhon@gmail.com'], [])
# wg2 = WorkGroup.new(453, 531_354,
#                     'Test', ['jhon@gmail.com', 'blablabla'], [])
wgm = WorkGroupManager.new

wg.add_group_task('eat')
wg.add_group_task('sleep')
wg.add_group_task('repeat')
wg.delete_group_task(1)

wgm.save_group(wg)
