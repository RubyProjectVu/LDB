require_relative 'work_group'
require_relative 'work_group_manager'

wg = WorkGroup.new('4654', 'TestGroup', nil, nil)
wg2 = WorkGroup.new('657355', 'TestGroup2', nil, nil)
wgm = WorkGroupManager.new


wgm.save_group(wg)
wgm.save_group(wg2)
