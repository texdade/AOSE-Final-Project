;; Problem Instance
(define (problem example) 
    (:domain n-puzzle)
    (:objects 
        tile1 tile2 tile3 tile4 tile5 tile6 tile7 tile8 tile9 tile10 tile11 tile12 tile13 tile14 tile15 - tile 
        pos1 pos2 pos3 pos4 pos5 pos6 pos7 pos8 pos9 pos10 pos11 pos12 pos13 pos14 pos15 pos16 - pos
    )
    (:init
        (adj pos1 pos2)(adj pos2 pos1)(adj pos2 pos3)(adj pos3 pos2)(adj pos3 pos4)(adj pos4 pos3)
        (adj pos1 pos5)(adj pos5 pos1)(adj pos2 pos6)(adj pos6 pos2)(adj pos3 pos7)(adj pos7 pos3)(adj pos4 pos8)(adj pos8 pos4)
        (adj pos5 pos6)(adj pos6 pos5)(adj pos6 pos7)(adj pos7 pos6)(adj pos7 pos8)(adj pos8 pos7)
        (adj pos5 pos6)(adj pos6 pos5)(adj pos6 pos10)(adj pos10 pos6)(adj pos7 pos11)(adj pos11 pos7)(adj pos8 pos12)(adj pos12 pos8)
        (adj pos9 pos10)(adj pos10 pos9)(adj pos10 pos11)(adj pos11 pos10)(adj pos11 pos12)(adj pos12 pos11)
        (adj pos9 pos13)(adj pos13 pos9)(adj pos10 pos14)(adj pos14 pos10)(adj pos11 pos15)(adj pos15 pos11)(adj pos12 pos16)(adj pos16 pos12)
        (adj pos13 pos14)(adj pos14 pos13)(adj pos14 pos15)(adj pos15 pos14)(adj pos15 pos16)(adj pos16 pos15)
        (on empty_tile pos16)
        (on tile15 pos1) (on tile2 pos2) (on tile1 pos3) (on tile12 pos4)
        (on tile8 pos5) (on tile5 pos6) (on tile6 pos7) (on tile11 pos8)
        (on tile4 pos9) (on tile9 pos10) (on tile10 pos11) (on tile7 pos12)
        (on tile3 pos13) (on tile13 pos14) (on tile14 pos15)
    )
    (:goal (and
        (on tile1 pos1) (on tile2 pos2) (on tile3 pos3) (on tile4 pos4)
        (on tile5 pos5) (on tile6 pos6) (on tile7 pos7) (on tile8 pos8)
        (on tile9 pos9) (on tile10 pos10) (on tile11 pos11) (on tile12 pos12)
        (on tile13 pos13) (on tile14 pos14) (on tile15 pos15)
    ))
)