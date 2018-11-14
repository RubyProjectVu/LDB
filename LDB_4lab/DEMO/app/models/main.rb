require './LDB'

User.destroy_all
Project.destroy_all
ProjectMember.destroy_all

user = User.create(name: 'demo', email: 't@a.com')
proj = Project.create(name: 'projektas')

id = Project.last.id
puts 'All project ids:'
puts (Project.all).ids
puts 'and last one:'
puts id

ProjectMember.create(projid: id, member: 'john')

puts 'Project member table:'
all = ProjectMember.all
all.each do |t|
  puts t.member
end

puts 'Project has members:'
proj = Project.find_by id: id
puts proj.members_getter
puts proj.members_getter.member

User.destroy_all
Project.destroy_all
ProjectMember.destroy_all
