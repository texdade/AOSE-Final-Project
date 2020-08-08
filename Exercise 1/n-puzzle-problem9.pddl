;; Problem Instance
(define (problem example) 
    (:domain n-puzzle)
    (:objects 
        tile1 tile2 tile3 tile4 tile5 tile6 tile7 tile8 - tile 
        pos1 pos2 pos3 pos4 pos5 pos6 pos7 pos8 pos9 - pos
    )
    (:init
        (adj pos1 pos2)(adj pos2 pos1)
        (adj pos2 pos3)(adj pos3 pos2)
        (adj pos1 pos4)(adj pos4 pos1)
        (adj pos2 pos5)(adj pos5 pos2)
        (adj pos3 pos6)(adj pos6 pos3)
        (adj pos4 pos5)(adj pos5 pos4)
        (adj pos5 pos6)(adj pos6 pos5)
        (adj pos4 pos7)(adj pos7 pos4)
        (adj pos5 pos8)(adj pos8 pos5)
        (adj pos6 pos9)(adj pos9 pos6)
        (adj pos7 pos8)(adj pos8 pos7)
        (adj pos8 pos9)(adj pos9 pos8)
        (on empty_tile pos4)
        (on tile2 pos1) (on tile6 pos2) (on tile1 pos3)
        (on tile7 pos5) (on tile8 pos6) (on tile3 pos7) 
        (on tile5 pos8) (on tile4 pos9)
    )
    (:goal (and
        (on tile1 pos1) (on tile2 pos2) (on tile3 pos3)
        (on tile4 pos4) (on tile5 pos5) (on tile6 pos6)
        (on tile7 pos7) (on tile8 pos8)
    ))
)