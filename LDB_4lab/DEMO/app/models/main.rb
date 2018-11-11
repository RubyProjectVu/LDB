require './LDB'

user = User.create(name: 'demo', email: 't@a.com')
proj = Project.create(name: 'projektas')

id = Project.last.id
puts 'All project ids:'
puts (Project.all).ids
puts 'and last one:'
puts id

ProjectMember.create(projid: id, member: 'john')
print 'Project member table:'
puts ProjectMember.all

puts 'Project has members:'
proj = Project.find_by id: id
proj.members_getter
puts (User.all).size
puts User.first.name

#puts Project.first.id
#puts (Project.all).size
#puts (Project.all).ids

User.destroy_all
Project.destroy_all
ProjectMember.destroy_all
