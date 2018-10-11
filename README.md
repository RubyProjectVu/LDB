
# LDB

Loosely Developed BIM (building infrastructure management/modeling)

Projektu dokumentų, brėžinių valdymas. Darbo grupių, laiko sekimo, rolių apsaugos funkcionalumas.
Galimybė keistis tekstine, vaizdine informacija tarp vartotojų.

Komanda: Diamond

Elgė Klipčiūtė

Tadas Glumbakas

Paulius Staišiūnas

Aivaras Atkočaitis

Ernestas Kodis

# Tests

Run rspec from the root directory:
```ruby
rspec tests/rspec.rb
```

Inside Old directory (through VM, using Old archive):
rspec spec/*spec.rb
reek and rubocop is launched regularly inside Old directory.

Mutant is executed through ./run1.sh.

Mutation coverage:
100 - project merger; 
100 - work group; 
100 - user; 
in progress - project; 
100 - system; 
in progress - pdc (project data checker); 
in progress - udc (user data checker); 
