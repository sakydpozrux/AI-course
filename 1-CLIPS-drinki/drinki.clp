; 1. W czesci POSIADANE SKLADNIKI nalezy odkomentowac
;    te ze skladnikow ktore sie posiada.
; 2. clips
; 3. (load drinki.clp)
; 4. (reset) ;; <--- pisze ta instrukcje bo zawsze tego zapominalem
; 5. (run)


; ======================
;   TEMPLEJTY :
; ======================

(deftemplate zamienniki (slot brak) (multislot zamien))

(deftemplate drink_pattern
  (slot nazwa)
  (multislot skladniki)
)

; ======================
;  POSIADANE SKLADNIKI :
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
  (niebieskie_curacao)
  ;(pomaranczowe_curacao)
  ;(grenadyna)
  ;(syrop_cukrowy)
  ;(likier_pomaranczowy)
  (syrop_bananowy)
  ;(syrop_malinowy)
  ;(amaretto)
  (cukier_bialy)
  (cukier_trzcinowy)
  (miod)

;;; ==================
;;; napoje:
  ;(sok_bez_cukru)
  ;(sok_slodzony)
  ;(woda_niegazowana)
  ;(piwo_imbirowe)
  (wino_czerwone)
  ;(wino_imbirowe)
  ;(wino_wermut)
  ;(tonic)
  ;(cola)
  (szampan)

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

(deffacts zamienniki
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
)

; ======================
;    WZORY DRINKÓW :
; ======================

(deffacts wzory

  (drink_pattern (nazwa apple_jammy)
    (skladniki whisky jablko cynamon)
  )

  (drink_pattern (nazwa god_father)
    (skladniki whisky amaretto)
  )

  (drink_pattern (nazwa jame_son_julep)
    (skladniki whisky wino_wermut listki_miety)
  )

  (drink_pattern (nazwa new_yorker)
    (skladniki whisky cytryna wino_czerwone)
  )

  (drink_pattern (nazwa port_whisky_punch)
    (skladniki whisky pomarancza zurawina wino_czerwone)
  )

  (drink_pattern (nazwa pszczolka_na_rozy)
    (skladniki whisky grejpfrut  miod)
  )

  (drink_pattern (nazwa summer_crash)
    (skladniki whisky cytryna ananas jablko)
  )

  (drink_pattern (nazwa ward_eight)
    (skladniki whisky cytryna grenadyna)
  )

  (drink_pattern (nazwa watermellon_and_mint_collins)
    (skladniki whisky cytryna arbuz listki_miety)
  )

  (drink_pattern (nazwa whisky_breeze)
    (skladniki whisky zurawina grejpfrut)
  )

  (drink_pattern (nazwa whisky_cobbler)
    (skladniki whisky ananas pomarancza cytryna pomaranczowe_curacao)
  )

  (drink_pattern (nazwa whisky_ginger_beer)
    (skladniki whisky piwo_imbirowe)
  )

  (drink_pattern (nazwa whisky_mac)
    (skladniki whisky wino_imbirowe)
  )


  (drink_pattern (nazwa sunrise)
    (skladniki wodka pomarancza grenadyna)
  )

  (drink_pattern (nazwa banana_ivanov)
    (skladniki wodka banan cytryna limonka syrop_bananowu)
  )

  (drink_pattern (nazwa blue_lagoon)
    (skladniki wodka cytryna limonka niebieskie_curacao sprite)
  )

  (drink_pattern (nazwa classic_martini)
    (skladniki wodka wino_wermut)
  )

  (drink_pattern (nazwa kamikaze)
    (skladniki wodka limonka likier_pomaranczowy)
  )

  (drink_pattern (nazwa lemon_drop_tini)
    (skladniki wodka cytryna likier_pomaranczowy syrop_cukrowy)
  )

  (drink_pattern (nazwa seabreeze)
    (skladniki wodka zurawina grejpfrut)
  )

  (drink_pattern (nazwa warszawska_herbatka)
    (skladniki wodka cytryna syrop_cukrowy szampan)
  )

  (drink_pattern (nazwa wiaderko_oposa)
    (skladniki wodka limonka cukier_trzcinowy sprite)
  )

  (drink_pattern (nazwa wybora-bora)
    (skladniki wodka ananas limonka grenadyna piwo_imbirowe)
  )

  (drink_pattern (nazwa wsciekly_pies)
    (skladniki wodka syrop_malinowy tabasco)
  )

  (drink_pattern (nazwa 3001)
    (skladniki wodka limonka ananas niebieskie_curacao tonic sprite)
  )



  (drink_pattern (nazwa miodowe_daiquiri)
    (skladniki rum limonka miod)
  )

  (drink_pattern (nazwa anatro)
    (skladniki rum ananas cytryna likier_pomaranczowy syrop_cukrowy)
  )

  (drink_pattern (nazwa blue_hawaii)
    (skladniki rum limonka ananas niebieskie_curacao syrop_cukrowy)
  )

  (drink_pattern (nazwa cuba_libre)
    (skladniki rum limonka cola)
  )

  (drink_pattern (nazwa culto_a_la_vida)
    (skladniki rum cytryna limonka zurawina cukier_bialy)
  )

  (drink_pattern (nazwa el_presidente)
    (skladniki rum owoce ananas limonka grenadyna)
  )

  (drink_pattern (nazwa ginger_mojito)
    (skladniki rum limonka cukier_trzcinowy piwo_imbirowe imbir listki_miety)
  )

  (drink_pattern (nazwa plaze_havany)
    (skladniki rum owoce ananas syrop_cukrowy)
  )

  (drink_pattern (nazwa larchmont)
    (skladniki rum limonka likier_pomaranczowy syrop_cukrowy)
  )

  (drink_pattern (nazwa pineapple_mai_tai)
    (skladniki rum ananas pomarancza limonka likier_pomaranczowy grenadyna)
  )

  (drink_pattern (nazwa wow)
    (skladniki rum limonka likier_pomaranczowy syrop_cukrowy)
  )
)


; ======================
;  REGULY WNIOSKOWANIA :
; ======================

(defrule czy_jest_skladnikiem
  (drink_pattern (nazwa ?nazwa) (skladniki $? ?skladnik $?))
  =>
  ;(assert (jest_skladnikiem ?skladnik ?drink))
  (printout t "z " ?skladnik " mozna zrobic " ?nazwa crlf)
)

;(defrule pasuja_wszystkie_skladniki
;  ;(drink_pattern (?nazwa)
;  (while (TRUE)
;    (drink_pattern (nazwa ?nazwa) (skladniki $? ?skladnik $?))
;  )
;  =>
;  (printout t "SKLADNIK JAKIS: " ?skladnik crlf)
;)
