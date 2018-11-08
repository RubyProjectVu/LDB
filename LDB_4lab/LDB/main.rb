require './LDB'

user = User.create(name: 'demo')
proj = Project.create(name: 'projektas')
puts (User.all).size
puts User.first.name
User.destroy_all
