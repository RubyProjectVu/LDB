require_relative 'work_group'
require_relative 'work_group_manager'

wg = WorkGroup.new(453, 3324, 'Test', ['jhon@gmail.com'], [])
wg2 = WorkGroup.new(453, 531354, 'Test', ['jhon@gmail.com', 'blablabla'], [])
wgm = WorkGroupManager.new

wgm.save_group(wg)
wgm.save_group(wg2)
wgm.delete_group(wg2)
