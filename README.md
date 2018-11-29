
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

- ```LDB_4lab``` folderis. Cia visa rails-like struktura jau padaryta.
- Duombaze generuojama ```db/``` ruby schema.rb
- ```LDB_4lab``` folderyje yra failas ```application_record.rb``` tik del to, kad iseitu patogiai leisti ```bundle exec rspec``` is ```LDB_4lab``` folderio, nes pacios klases relative requirina si faila dar ir is ```app/model```.
- Visas kodas rasomas ```app/models```. Ten esantis dbfile skirtas tik pasizaidimui ir testuose nedalyvauja.
- ```db/``` schema.rb apraso lenteliu ir ju atributu sukurima. Cia yra ir pagrindine duombaze dbfile. Duombaze sukonfiguruota per ```config/``` database.yml.
- ```spec/models``` rasomi testai i _spec.rb failus, kaip ir anksciau. Duombaze bei klases pasigriebiamos per rails_helper automatiskai.
- ```spec/fixtures``` laikomi DB uzpildantys fixtures, kurie uzkraunami testu pradzioje.

### Testai

- Leisti testus su ```./run_tests.sh```

- [ ] LDB_4lab padengimas: 59.49%
- [x] 63 ex.
- [ ] 0/10 stubs
- [ ] 0/10 mocks
- [ ] reek klaidos: 48
- [ ] rubocop klaidos: 14
