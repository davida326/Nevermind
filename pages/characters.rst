############
Karakterek
############

.. TODO: A karakterek attribútumait összegyűjteni!

Attribútumok  
------------


**Élet attribútum**

.. list-table::
   :align: left

   * - .. image:: ./heart.png
         :align: center

     - .. image:: ./potion.gif
         :scale: 200 %
         :align: center


   
Az élet attribútum arra szolgál hogy, a felhasználó számára megjelenítse mennyi sebzést tud még elviselni, mielőtt meghal.
Játékon belül ez egy életcsík-ként jelenik meg, mivel az ellefelek sebzése véletlenszerű ezért a játékosnak folyton figyelemmel kell kísérnie, ha nem szeretne korán elhalálozni.
Az ellenfeleknek is van élet attribútuma és itt is ugyanígy működik.
Amennyiben a játékost sebzés éri, lehetősége van az életét visszatölteni Health Potion segítségével.


**Állóképesség/kitartás(Stamina) attribútum**

.. image:: ./Stamina.png


Néhány képesség mint például a dupla ugrás és a "dash" használata Állóképesség erőforrást használ, így amikor igénybe veszi a játékos ezeket, csökken az Állóképessége.
Ez az attribútum regenerálódik, amint a játékos nem használ ilyen erőforrást igényő képességet.
Itt is hasonlóan az élet attribútumhoz, a játékon belül staminacsík-ként jelenik meg.
Az ellenfeleknek nincs ilyen attribútumuk.


**Mana attribútum**

.. image:: ./Mana.png


Ezt az erőforrást a játékos haláltípushoz kapcsolódó képességekkel veszi igénybe.
Minden képesség támadáshoz manát fogyaszt, így figyelembe kell vennie a játékosnak hogy egyáltalán van-e elég manája, a választott képességhez.
A manaszint regenrálódnak abban az esetben, ha a játékos nem használ manát igénybevevő képességet.
Itt is mint az Élet és Állóképesség attribútumok is növelhetők ugrade-ek vásárlásával.
Az ellenfeleknek nincs ilyen attribútumuk.

**Gold**

.. list-table::
   :align: left
   
   * - .. image:: ./decil_coin.gif
         :align: center
     - .. image:: ./plus.png
         :align: center
         :width: 50
         :height: 50
     - .. image:: ./knife.png
         :align: center
     - .. image:: ./equal.png
         :align: center
         :width: 50
         :height: 50 
     - .. image:: ./devilhappy.png
         :align: center




Az aranynak a játékban fontos szerepe van mivel, ezt felhasználva vásárolhat a játékos az ördög npc-től upgrade-eket.
Lehetősége van a játékosnak, képesség, attribútum növelő fejlesztések vásárlására.
Aranyat a játékos a legyőzött ellenségektől, küldetések teljesítésével és a pálya rejtett részein szerezhet.


**Key**

.. list-table::
   :align: left

   * - .. image:: ./key_blue_anim.gif
         :scale: 150 %
         :align: center

     - .. image:: ./key_red_anim.gif
         :scale: 150 %
         :align: center

     - .. image:: ./key_yellow_anim.gif
         :scale: 150 %
         :align: center

     - .. image:: ./key_green_anim.gif
         :scale: 150 %
         :align: center

     - .. image:: ./lada.gif
         :align: center

     - .. image:: ./ajto.gif
         :align: center


A játékosnak az előrehaladás érdekében kulcsokat kell gyűjteni, speciális ajtók és ládák kinyitásához.
Kulcsokból négy féle változat létezik: piros, kék, zöld, sárga.
Néhány ajtóhoz több különböző színű kulcs szükséges, hogy az ajtót ki lehessen nyitni.
A kulcsok a pályán meghatározott helyen, el vannak rejtve, amiket a játékosnak meg kell találnia.
A játékos egy színből egy kulcsot tárolhat, így összesen négy különböző színű kulcsot tarthat magánál, amiket később felhasználhat ajtók kinyitásához.


.. TODO: Karakter típusok, hierarchiák, ...
Egy fő karakter típus lesz, haláltól függően a karakternek megváltozik a kinézete és a képessége.
Ellenfélből két féle lesz: egy közelharci és egy távharcos.(lövöldöz ránk)

**Karakter típusok**

A főhős:
---------
.. image:: ./programmer.png
.. image:: ./mug.png
           :scale: 200 %

A játék során ő az egyetlen irányítható karakter. Közelharci támadása bármilyen haláltípusnál használható, ami nem igényel manát.
A közelharci támadáshoz legalább 1 block közel kell állnia a játékosnak az ellenféltől.
Közelharci támadást minden haláltípus karakterrel végre lehet hajtani.
A programozó karakter speciális képessége a bögréjének elhajítása.
Ez elsőre nem tűnhet félelmetes támadásnak, ám igen hatékony, mivel a programozó karakternek nagy gyakorlata van benne.


Attribútumai:

* Sebzés: Bögre hajítás (1-3)

* Élet: 12

* Állóképesség: 12

* Mana: 12

* Mozgási sebesség: 300(Max)

* Karakter inventory: arany(helyi fizetőeszköz), kulcsok (maximum 4 db különböző színű kulcs lehet nála)

A különböző halálképességeinek sebzése 1.5-3.5 (kezdetben, ez később fejleszthető), ezeknek használata 3 manapont.
A képességeket 2 másodperc lehülési idő elteltével használhatja.

Főhős halálképességei:
----------------------

A halálképességek beáltakor, ugyanazzal az élet/Állóképesség/mana attribútum mennyiséggel osztoznak a különböző karakterek.

**Repülő halálképesség**

.. image:: ./repulohalal.gif

A főhőst, ha magas zuhánás általi halál éri, ez a haláltípus áll be nála.
Passzív képességének tekinthető hogy tud repülni és emiatt többé képtelen meghalni árokba zuhanástól.

Speciális képességéhez a karmait használja amit mélyen az ellenfélbe mélyeszt, ennek a képességnek az ára 1 manatöltés.
Miután használta a képességet, jelentkezni fog egy lehülési idő ami 2 másodperc, ezt követően tudja újra használni a képességet, abban az esetben ha van elegendő manája.

* A képesség sebzése: 4

* Mozgási sebesség: 450(Max)

**Tűz halálképesség**

.. image:: ./tuzhalal.png

Abban az esetben veheti fel a játékos, ezt a képességet hogyha tűz általi halált hal.
Ezt robbanó hordók, Lángszórós rosszfiú karakter tudja előidézni.
Ekkor a játékos egy láng démonná alakul, és emiatt többet nem sebezheti a tűz/robbanás.

Speciális képessége, hogy egy tűzgolyót lő az ellensége felé.
A képesség használata után 2 másodperc lehülési idő, lép életbe.

* A képesség sebzése: 3-4

* Mozgási sebesség: 300(Max)

**Vas halálképesség**

.. image:: ./vashala.png

A játékost hogyha a gépfegyveres kolléga, túl sokszor eltalálja és meghal.
Főhősünk ezzel a halálképességgel fog újraéledni.

Speciális képessége, hogy hosszú karjait használva egy erőütést hajt végre.
A képesség használata után 2 másodperc lehülési idő, lép életbe.

* A képesség sebzése: 3-5 

* Mozgási sebesség: 200(Max)

A gépfegyveres kolléga:
----------------------
.. image:: ./thugnon.png

Ellenséges npc, általában őrt áll valahol vagy éppen járőrözik.
Amint a játékos bekerül a látóterébe, a kolléga megtámadja őt.
A játékosnak vigyáznia kell vele mert ő távolról is képes igen nagy sebzést okozni. Érdemes fedezékből fedezékbe közelíteni hozzá.
Az kollégának 15 block távolságú a látótere.


Attribútumai:
* Sebzés: 2-4

* Élet: 8

* Mana: nincs

* Állóképesség: nincs 

Amikor támad a játékosra, és az túl közel kerül, megpróbál elmenekülni és távolról újra felvenni vele a harcot.
(megpróbál 10 block távolságra lenni tőle és újra tüzel)
Mozgási sebesség: 250(Max)


Lángszórós rosszfiú:
-------------------
.. image:: ./flame.png

Ellenséges npc, amint észreveszi a főhőst, megpróbál közel kerülni hozzá és a lángszórójával elégetni.

Attribútumai:

* Sebzés: 1-3

* Élet: 10

* Mana: nincs

* Állóképesség: nincs

A játékos felhasználót 15 block távolságról kiszúrja, és ha nincs takarásban, elindul felé hogy támadjon.
Mozgási sebesség: 150(Max)

Ördög
-----
.. image:: ./devilinhell.png

Semleges npc, a főhős főnöke...
A játékos tőle tud vásárolni fejlesztéseket a speciális képességeihez, illetve passzív upgrade-eket is vehet mint például Élet, Mana, Állóképesség növelés.
A főhős, az "E" interakció gombbal tud vele kommunkálni.
Gyakori monológja hogy: "Everything has a price..."

.. TODO: Skill tree és hasonlók, fejlődési lehetőségek

**Skill fa és fejlődési lehetőségek**

.. image:: ./skilltree.png
    :width: 128px
    :height: 128px

A játék során ahogy halad előre a főhős, újabb és újabb képességekre tesz majd szert azáltal hogy különböző tragikus halálokat hal.
Amitől a főhős meghalt, újraéledése után immunis lesz. Így ha éppen felgyújtották, és elégett, újraéledését követően nem okozhatja halálát a tűz sebzése.
A játékban négy alap haláltípus létezik, amelyekhez egyedi tamádási képességek is tartoznak.
Minden haláltípushoz egyedi skill-fa társul. A képességek fejlesztésére van lehetősége a játékosnak, amit meghatározott mennyiségű arannyal vásárolhat az ördögtől.
A fejlesztések vásárlásával a képességek kevesebb manát használnak illetve nagyobb sebzést tesz lehetővé, ami az előrehaladást igencsak megkönnyíti.

.. TODO: Megjelenítéssel, előnyökkel/hátrányokkal kapcsolatos leírások.

Megjelenítés
-----------

Karakterek szempontjából 64x64 pixel felbontás mellett döntöttünk és ehhez mérten próbáltuk méretezni a többi elemet.
Úgy gondoltuk hogy ez ideális méret a karaktereknek, és mivel mindkettőnknek hasonlított az elképzeléséhez a végeredmény ezért ennél maradtunk.

.. image:: ./respiskel.png
            :align: left
.. image:: ./devilpiskel.png
           :scale: 25 %         

.. image:: ./programmerpiskel.png
            :scale: 25 %




