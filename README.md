
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

- ```LDB_4lab/DEMO``` folderis. Cia visa rails-like struktura jau padaryta.
- ```main.rb``` pasibandymui, kaip veikia. main kuria objektus (kurie per schema imetami ir i lenteles, kurios kol kas laikomos dbfile (tiek ant ```app/models/```, tiek ant ```spec/models```)). 
- ```DEMO``` folderyje yra failas ```application_record.rb``` tik del to, kad iseitu patogiai leisti ```bundle exec rspec``` is ```DEMO``` folderio, nes pacios klases relative requirina si faila dar ir is ```app/model``` - is ten leidziam, nes ten yra dbfile.
- Visas kodas rasomas ```app/models```. Ten esantis dbfile skirtas tik pasizaidimui ir testuose nedalyvauja.
- ```db/``` schema.rb apraso lenteliu ir ju atributu sukurima. Cia yra ir pagrindine duombaze dbfile. Duombaze sukonfiguruota per ```config/``` database.yml.
- ```spec/models``` rasomi testai i _spec.rb failus, kaip ir anksciau. Duombaze bei klases pasigriebiamos per rails_helper automatiskai.
- ```spec/fixtures``` laikomi DB uzpildantys fixtures, kurie uzkraunami testu pradzioje.

### Testai

- Leisti testus su ```./run_tests.sh```

- [x] LDB_3lab padengimas: 100%
- [x] 259 ex.
- [x] 10/10 custom matchers
- [x] 25 standard matchers listed on ```LDB_3lab```, as ```expects```
- [x] reek klaidos: 0.
- [x] rubocop klaidos: 0
