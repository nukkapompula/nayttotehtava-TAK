# Näyttötehtävä-TAK

Bash-skripti lukee käyttäjien tiedot CSV-tiedostosta ja luo kullekin käyttäjätunnuksen (`etunimi.sukunimi`), kotihakemiston sekä *public_html*-kansion. Skriptiä voidaan kutsua antamalla CSV-tiedosto parametrinä.

Huomioitavaa:

- CSV-tiedoston **students.csv** rivit ovat muotoa `etunimi,sukunimi,salasana,ryhmä`. Ensimmäinen rivi pitää sisällään nämä ohjetiedot eikä sitä täten oteta huomioon käyttäjiä luodessa!

- Luotava kotihakemisto sisältää kansion *public_html*, josta löytyy puolestaan *index.html*. Sivu kertoo kuka sen omistaa.

- Kaikille käyttäjille tulee luoda samanniminen ryhmä kuin CSV-tiedostossa, ja käyttäjä liitetään tähän ryhmään. Lisäksi Apache WWW-palvelimen käyttäjä täytyy liittää jokaisen käyttäjän ryhmään.

- Kotihakemiston käyttöoikeudet ovat vain käyttäjällä itsellään sekä hänen ryhmällään.