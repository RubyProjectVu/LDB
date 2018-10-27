require_relative 'work_group'
require_relative 'work_group_manager'

wg = WorkGroup.new('4654', 'TestGroup', nil, nil)
wgm = WorkGroupManager.new

wgm.save_group(wg)
