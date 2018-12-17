
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

#### (For devs) Kur vyksta 5lab veiksmas?

- ```LDB_5lab``` folderis. Cia visa rails-like struktura perkelta is 4 lab.
- Duombaze generuojama ```db/``` ruby schema.rb
- Visas kodas rasomas ```app/models```, ```app/views``` ir ```app/controllers```.
- ```db/``` schema.rb apraso lenteliu ir ju atributu sukurima. Cia yra ir pagrindine duombaze dbfile. Duombaze sukonfiguruota per ```config/``` database.yml. Viskas lieka po senovei is 4 lab. Teoriskai modeliu struktura jau baigta.
- ```spec/fixtures``` laikomi DB uzpildantys fixtures, kurie uzkraunami testu pradzioje. Siuo metu app naudoja ```dbfile``` prod aplinkoje, o ```dbtest``` test aplinkoje -  ten galima aptikti uzkrautus duomenis is fixtures.

### Testai

- Leisti testus su ```run_tests.sh```

- [x] LDB_5lab padengimas: 100%
- [x] 65+/50 GET/POST testu
- [x] 11/10 stubs kontroleriams
- [x] 10/10 mocks kontroleriams
- [x] 26/25 views testai
- [x] reek klaidos: 0
- [x] rubocop klaidos: 0
