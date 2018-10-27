require 'rainbow'
require 'tty/cursor'
require 'tty/prompt'
require 'time'

#works on LINUX best

cursor = TTY::Cursor
prompt = TTY::Prompt.new
puts cursor.clear_screen

puts cursor.move_to(0,0)
puts Rainbow("LDB\t").bright + Rainbow('[' + Date.today.to_s + ']').green

choice = prompt.select("", %w(Sign\ up Login Exit))
puts cursor.clear_lines(2, :up)

case choice
when 'Sign up'
  puts cursor.clear_screen
  prompt.ask('Email:')
  prompt.mask('Password:')
  prompt.mask('Repeat password:')
  puts 'Signing up here'
when 'Login'
  puts 'Logging in here'
else
  # ...
end

puts cursor.clear_screen
#email = gets.chomp
#pwd = gets.chomp

