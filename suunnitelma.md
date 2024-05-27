# Näyttötehtävä-TAK

Bash-skripti lukee käyttäjien tiedot CSV-tiedostosta ja luo kullekin käyttäjätunnuksen (`etunimi.sukunimi`), kotihakemiston sekä *public_html*-kansion. Skriptiä voidaan kutsua antamalla CSV-tiedosto parametrinä.

Huomioitavaa:

- CSV-tiedoston **students.csv** rivit ovat muotoa `etunimi,sukunimi,salasana,ryhmä`. Ensimmäinen rivi pitää sisällään nämä ohjetiedot eikä sitä täten oteta huomioon käyttäjiä luodessa!

- Luotava kotihakemisto sisältää kansion *public_html*, josta löytyy puolestaan *index.html*. Sivu kertoo kuka sen omistaa.

- Kaikille käyttäjille tulee luoda samanniminen ryhmä kuin CSV-tiedostossa, ja käyttäjä liitetään tähän ryhmään. Lisäksi Apache WWW-palvelimen käyttäjä täytyy liittää jokaisen käyttäjän ryhmään.

- Kotihakemiston käyttöoikeudet ovat vain käyttäjällä itsellään sekä hänen ryhmällään.

- Skriptistä on kaksi versiota: **user-creator1.sh** luo tarvittavat kansiot käyttäjän kotihakemistoon, kun taas **user-creator2.sh** käyttää VirtualHostia eli sivut tehdään polkuun */var/www/<etunimi.sukunimi>/public_html*. Myös tarvittavat **.conf**-tiedostot luodaan sijaintiin */etc/apache2/sites-available*.

Toteutuksesta:

- CSV-tiedoston rivien tiedot iteroidaan *while*-silmukalla. Siellä käyttäjille luodaan kotihakemistot, koko nimi sekä ryhmä; käyttäjä **www-data** liitetään lisäksi jokaisen käyttäjän omaan ryhmään. Silmukassa kutsutaan funktiota **create_html** jolle syötetään parametreiksi CSV-tiedostosta poimitut etu- ja sukunimi. Nämä tiedot kirjataan funktiossa itse HTML-koodiin ilmaisemaan sivun omistajaa. HTML-tiedosto luodaan kansioon *public_html* ja kyseinen kansio siirretään käyttäjän kotihakemistoon. Kansion omistajaksi vaihdetaan käyttäjä **www-data**. Lopuksi hakemiston luku-, kirjoitus- ja suoritusoikeudet päivitetään CSV-tiedostossa osoitetulle ryhmälle kuuluvaksi. 