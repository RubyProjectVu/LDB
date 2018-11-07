require './LDB'

user = User.create(name: 'demo')
proj = Project.create(name: 'projektas')
puts User.first.name
