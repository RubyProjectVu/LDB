
# LDB

Loosely Developed BIM (building infrastructure management/modeling)

Projektu dokumentų, brėžinių valdymas. Darbo grupių, laiko sekimo, rolių apsaugos funkcionalumas.
Galimybė keistis tekstine, vaizdine informacija tarp vartotojų.

Komanda: Diamond

-Eglė Klipčiūtė
-Tadas Glumbakas
-Paulius Staišiūnas
-Aivaras Atkočaitis
-Ernestas Kodis

# (For devs) Kur vyksta 4lab veiksmas?

```LDB_4lab/LDB``` folderis. ```LDB.rb``` sukuria schema su lentelemis - cia yra nurodomi ir atributai, plius reikalingos klases, paveldincios is ApplicationRecord. ```main.rb``` kuria objektus (kurie per schema imetami ir i lenteles, kurios kol kas laikomos RAMe).

# Testai

Leisti rspec kaip ```LDB_3lab/spec```; ```rspec *spec.rb```

Leisti mutant kaip ```LDB_3lab```; ```./run.sh```. Atsiklonavus saka is github isitikinti, kad run.sh turi leidima buti paleistam kaip executable file.

LDB_3lab padengimas: 100%

169 ex.

9 custom matchers

25 standard matchers listed on ```LDB_3lab```, as ```expects```

reek klaidos: 0. rubocop klaidos: 0

# Ruby stilius
Leisti reek kaip root ```sudo reek``` arba ```reek -c [configuration file]```. Kitu atveju reek.yml failo konfigūracijos nepasigriebia.
rubocop leidžiamas įprastai.

# Esantis funkcionalumas

...bus papildyta 18-11-09...
