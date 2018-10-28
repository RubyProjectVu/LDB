require_relative 'work_group'
require_relative 'work_group_manager'

wg = WorkGroup.new(553, 3324, 'Test', ['jhon@gmail.com'], ['fix that', 'and that'])
wgm = WorkGroupManager.new

wgm.save_group(wg)
