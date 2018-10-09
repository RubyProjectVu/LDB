
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
rspec standalone/*spec.rb
reek and rubocop is launched regularly inside Old directory.

Mutant is executed through ./run1.sh. The *spec.rb files have to be uploaded to Old/spec file before running mutations.

Mutation coverage:
85 - project merger; 
97 - work group; 
98 - user; 
69 - project; 
98 - system; 
97 - pdc; 
98 - sgl; 
98 - spl; 
98 - sul; 
97 - udc; 
