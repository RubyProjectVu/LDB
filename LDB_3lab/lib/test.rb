require_relative 'work_group'
require_relative 'work_group_manager'

wg = WorkGroup.new(453, 3324, 'Test', ['jhon@gmail.com'], [])
wgm = WorkGroupManager.new

if !wgm.delete_group(wg)
  puts "NO KEY"
end
