
### LDB

Loosely Developed BIM (building infrastructure management/modeling)

Projektu dokumentų, brėžinių valdymas. Darbo grupių, laiko sekimo, rolių apsaugos funkcionalumas.
Galimybė keistis tekstine, vaizdine informacija tarp vartotojų.

Komanda: Diamond

- Eglė Klipčiūtė
- Tadas Glumbakas
- Paulius Staišiūnas
- Aivaras Atkočaitis
- Ernestas Kodis

#### (For devs) Kur vyksta 4lab veiksmas?

```LDB_4lab/DEMO``` folderis. ```LDB.rb``` sukuria schema su lentelemis - cia yra nurodomi ir atributai, plius reikalingos klases, paveldincios is ApplicationRecord. ```main.rb``` kuria objektus (kurie per schema imetami ir i lenteles, kurios kol kas laikomos dbfile (tiek ant ```app/models/```, tiek ant ```spec/models```)). ```DEMO``` folderyje yra failas ```application_record.rb``` tik del to, kad iseitu patogiai leisti ```bundle exec rspec``` is ```DEMO``` folderio, nes pacios klases relative requirina si faila dar ir is ```app/model``` - is ten leidziam, nes ten yra dbfile.

### Testai

- Leisti rspec kaip ```LDB_3lab/spec```; ```rspec *spec.rb``` (nieko neatsitiks ir nuo ```rspec spec/*spec.rb``` is pagrindines direktorijos, tik kad gausim ```coverage``` aplanka neesminej vietoj (plius coverage nevisai tikslus berods)).
- Leisti mutant kaip ```LDB_3lab```; ```./run.sh```. Atsiklonavus saka is github isitikinti, kad run.sh turi leidima buti paleistam kaip executable file.
- [x] LDB_3lab padengimas: 100%
- [x] 169 ex.
- [ ] 9/10 custom matchers
- [x] 25 standard matchers listed on ```LDB_3lab```, as ```expects```
- [x] reek klaidos: 0.
- [x] rubocop klaidos: 0

### Ruby stilius
Leisti reek kaip root ```sudo reek``` arba ```reek -c [configuration file]```. Kitu atveju reek.yml failo konfigūracijos nepasigriebia.
rubocop leidžiamas įprastai.

### Esantis funkcionalumas

...bus papildyta 18-11-11...
