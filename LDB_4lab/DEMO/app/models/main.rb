require './LDB'

user = User.create(name: 'demo')
proj = Project.create(name: 'projektas')
puts (User.all).size
puts User.first.name

puts Project.first.id
puts (Project.all).size
puts (Project.all).ids

User.destroy_all
Project.destroy_all
