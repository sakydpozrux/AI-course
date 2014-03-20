;[TODO] dokumentacja tutaj
; w komentarzu albo osobny plik README.md


; ======================
;   TEMPLATES SECTION :
; ======================

(deftemplate zamienniki (slot brak) (multislot zamien))

(deftemplate drink_pattern
  (slot nazwa)
  (multislot mocne_alkohole)
  (multislot owoce)
  (multislot slodziki)
  (multislot napoje)
  (multislot dodatki)
  (multislot przyprawy)
)

; ======================
;    STARTUP FACTS :
; ======================

(deffacts startup
;;; =================
;;; mocne_alkohole:
  ;(whisky)
  (wodka)
  (rum)

;;; ==================
;;; owoce:
  (cytryna)
  ;(limonka)
  (pomarancza)
  (jablko)
  (ananas)
  ;(grejpfrut)
  ;(zurawina)
  (banan)
  ;(arbuz)
  ;(kiwi)
  ;(truskawka)

;;; ==================
;;; slodziki:
  ;(niebieskie_curacao)
  ;(pomaranczowe_curacao)
  ;(grenadyna)
  ;(syrop_cukrowy)
  ;(likier_pomaranczowy)
  ;(syrop_bananowy)
  ;(syrop_malinowy)
  ;(amaretto)
  ;(cukier_bialy)
  ;(cukier_trzcinowy)
  ;(miod)

;;; ==================
;;; napoje:
  ;(sok_bez_cukru)
  ;(sok_slodzony)
  ;(woda_niegazowana)
  ;(piwo_imbirowe)
  ;(wino_czerwone)
  ;(wino_imbirowe)
  ;(wino_wermut)
  ;(tonic)
  ;(cola)
  ;(szampan)

;;; ==================
;;; dodatki:
  (lod)

;;; ==================
;;; przyprawy:
  ;(cynamon)
  ;(listki_miety)
  (tabasco)
  ;(imbir)

)


; ======================
;    ZAMIENNIKI :
; ======================

;;; =================
;;; mocne_alkohole:
  (zamienniki (brak whisky) (zamien rum wodka))
  (zamienniki (brak wodka) (zamien rum whisky))
  (zamienniki (brak rum) (zamien whisky wodka))

;;; ==================
;;; owoce:
  (zamienniki (brak cytryna) (zamien pomarancza limonka))
  (zamienniki (brak limonka) (zamien cytryna pomarancza))
  (zamienniki (brak pomarancza) (zamien cytryna limonka))
  (zamienniki (brak jablko) (zamien ))
  (zamienniki (brak ananas) (zamien grejpfrut arbuz))
  (zamienniki (brak grejpfrut) (zamien ananas arbuz))
  (zamienniki (brak zurawina) (zamien ))
  (zamienniki (brak banan) (zamien ananas))
  (zamienniki (brak arbuz) (zamien ananas grejpfrut))
  (zamienniki (brak kiwi) (zamien truskawka))
  (zamienniki (brak truskawka) (zamien kiwi))

;;; ==================
;;; slodziki:
  (zamienniki (brak niebieskie_curacao) (zamien pomaranczowe_curacao))
  (zamienniki (brak pomaranczowe_curacao) (zamien niebieskie_curacao))
  (zamienniki (brak grenadyna) (zamien pomaranczowe_curacao))
  (zamienniki (brak syrop_cukrowy) (zamien cukier_bialy cukier_trzcinowy))
  (zamienniki (brak likier_pomaranczowy) (zamien ))
  (zamienniki (brak syrop_bananowy) (zamien syrop_malinowy))
  (zamienniki (brak syrop_malinowy) (zamien syrop_bananowy))
  (zamienniki (brak amaretto) (zamien ))
  (zamienniki (brak cukier_bialy) (zamien syrop_cukrowy cukier_trzcinowy))
  (zamienniki (brak cukier_trzcinowy) (zamien cukier_bialy))
  (zamienniki (brak miod) (zamien syrop_malinowy syrop_cukrowy syrop_cukrowy))

;;; ==================
;;; napoje:
  (zamienniki (brak sok_bez_cukru) (zamien ))
  (zamienniki (brak sok_slodzony) (zamien tonic cola))
  (zamienniki (brak woda_niegazowana) (zamien ))
  (zamienniki (brak piwo_imbirowe) (zamien wino_imbirowe imbir))
  (zamienniki (brak wino_czerwone) (zamien wino_wermut szampan))
  (zamienniki (brak wino_imbirowe) (zamien piwo_imbirowe imbir))
  (zamienniki (brak wino_wermut) (zamien wino_czerwone szampan))
  (zamienniki (brak tonic) (zamien cola syrop_cukrowy cukier_bialy))
  (zamienniki (brak cola) (zamien tonic syrop_cukrowy cukier_bialy))
  (zamienniki (brak szampan) (zamien wino_imbirowe piwo_imbirowe))

;;; ==================
;;; dodatki:
  (zamienniki (brak lod) (zamien ))

;;; ==================
;;; przyprawy:
  (zamienniki (brak cynamon) (zamien tabasco))
  (zamienniki (brak listki_miety) (zamien ))
  (zamienniki (brak tabasco) (zamien cynamon))
  (zamienniki (brak imbir) (zamien piwo_imbirowe wino_imbirowe))


; ======================
;    WZORY DRINKÓW :
; ======================


(drink_pattern (nazwa apple_jammy)
  (mocne_alkohole whisky)
  (owoce jablko)
  (slodziki )
  (napoje )
  (dodatki )
  (przyprawy cynamon)
)


(drink_pattern (nazwa god_father)
  (mocne_alkohole whisky)
  (owoce )
  (slodziki amaretto)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa jame_son_julep)
  (mocne_alkohole whisky)
  (owoce )
  (slodziki )
  (napoje wino_wermut)
  (dodatki )
  (przyprawy listki_miety)
)

(drink_pattern (nazwa new_yorker)
  (mocne_alkohole whisky)
  (owoce cytryna)
  (slodziki )
  (napoje wino_czerwone)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa port_whisky_punch)
  (mocne_alkohole whisky)
  (owoce pomarancza zurawina)
  (slodziki )
  (napoje wino_czerwone)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa pszczolka_na_rozy)
  (mocne_alkohole whisky)
  (owoce grejpfrut)
  (slodziki miod)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa summer_crash)
  (mocne_alkohole whisky)
  (owoce cytryna ananas jablko)
  (slodziki )
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa ward_eight)
  (mocne_alkohole whisky)
  (owoce cytryna)
  (slodziki grenadyna)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa watermellon_and_mint_collins)
  (mocne_alkohole whisky)
  (owoce cytryna arbuz)
  (slodziki )
  (napoje )
  (dodatki )
  (przyprawy listki_miety)
)

(drink_pattern (nazwa whisky_breeze)
  (mocne_alkohole whisky)
  (owoce zurawina grejpfrut)
  (slodziki )
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa whisky_cobbler)
  (mocne_alkohole whisky)
  (owoce ananas pomarancza cytryna)
  (slodziki pomaranczowe_curacao)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa whisky_ginger_beer)
  (mocne_alkohole whisky)
  (owoce )
  (slodziki )
  (napoje piwo_imbirowe)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa whisky_mac)
  (mocne_alkohole whisky)
  (owoce )
  (slodziki )
  (napoje wino_imbirowe)
  (dodatki )
  (przyprawy )
)


(drink_pattern (nazwa sunrise)
  (mocne_alkohole wodka)
  (owoce pomarancza)
  (slodziki grenadyna)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa banana_ivanov)
  (mocne_alkohole wodka)
  (owoce banan cytryna limonka)
  (slodziki syrop_bananowu)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa blue_lagoon)
  (mocne_alkohole wodka)
  (owoce cytryna limonka)
  (slodziki niebieskie_curacao)
  (napoje sprite)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa classic_martini)
  (mocne_alkohole wodka)
  (owoce )
  (slodziki )
  (napoje wino_wermut)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa kamikaze)
  (mocne_alkohole wodka)
  (owoce limonka)
  (slodziki likier_pomaranczowy)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa lemon_drop_tini)
  (mocne_alkohole wodka)
  (owoce cytryna)
  (slodziki likier_pomaranczowy syrop_cukrowy)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa seabreeze)
  (mocne_alkohole wodka)
  (owoce zurawina grejpfrut)
  (slodziki )
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa warszawska_herbatka)
  (mocne_alkohole wodka)
  (owoce cytryna)
  (slodziki syrop_cukrowy)
  (napoje szampan)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa wiaderko_oposa)
  (mocne_alkohole wodka)
  (owoce limonka)
  (slodziki cukier_trzcinowy)
  (napoje sprite)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa wybora-bora)
  (mocne_alkohole wodka)
  (owoce ananas limonka)
  (slodziki grenadyna)
  (napoje piwo_imbirowe)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa wsciekly_pies)
  (mocne_alkohole wodka)
  (owoce )
  (slodziki syrop_malinowy)
  (napoje )
  (dodatki )
  (przyprawy tabasco)
)

(drink_pattern (nazwa 3001)
  (mocne_alkohole wodka)
  (owoce limonka ananas)
  (slodziki niebieskie_curacao)
  (napoje tonic sprite)
  (dodatki )
  (przyprawy )
)



(drink_pattern (nazwa miodowe_daiquiri)
  (mocne_alkohole rum)
  (owoce limonka)
  (slodziki miod)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa anatro)
  (mocne_alkohole rum)
  (owoce ananas cytryna)
  (slodziki likier_pomaranczowy syrop_cukrowy)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa blue_hawaii)
  (mocne_alkohole rum)
  (owoce limonka ananas)
  (slodziki niebieskie_curacao syrop_cukrowy)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa cuba_libre)
  (mocne_alkohole rum)
  (owoce limonka)
  (slodziki )
  (napoje cola)
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa culto_a_la_vida)
  (mocne_alkohole rum)
  (owoce cytryna limonka zurawina)
  (slodziki cukier_bialy)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa el_presidente)
  (mocne_alkohole rum)
  (owoce ananas limonka)
  (slodziki grenadyna)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa ginger_mojito)
  (mocne_alkohole rum)
  (owoce limonka)
  (slodziki cukier_trzcinowy)
  (napoje piwo_imbirowe)
  (dodatki )
  (przyprawy imbir listki_miety)
)

(drink_pattern (nazwa plaze_havany)
  (mocne_alkohole rum)
  (owoce ananas)
  (slodziki syrop_cukrowy)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa larchmont)
  (mocne_alkohole rum)
  (owoce limonka)
  (slodziki likier_pomaranczowy syrop_cukrowy)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa pineapple_mai_tai)
  (mocne_alkohole rum)
  (owoce ananas pomarancza limonka)
  (slodziki likier_pomaranczowy grenadyna)
  (napoje )
  (dodatki )
  (przyprawy )
)

(drink_pattern (nazwa wow)
  (mocne_alkohole rum)
  (owoce limonka)
  (slodziki likier_pomaranczowy syrop_cukrowy)
  (napoje )
  (dodatki )
  (przyprawy )
)


