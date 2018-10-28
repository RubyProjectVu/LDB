require_relative 'work_group'
require_relative 'work_group_manager'

wg = WorkGroup.new(553, 3324, 'Test', ['jhon@gmail.com'], [])
wg2 = WorkGroup.new(453, 643, 'baba', ['jhon@gmail.com'], [])
wgm = WorkGroupManager.new

wg.add_group_task('trolololo')
wg.add_group_task('mememmeme')

wgm.save_group(wg)
wgm.save_group(wg2)
