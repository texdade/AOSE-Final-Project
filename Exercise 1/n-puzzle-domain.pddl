; domain file: n-puzzle-domain.pddl
(define (domain n-puzzle)
    (:types tile pos)
    (:constants empty_tile - tile)
    (:predicates 
        (adj ?x ?y - pos)
        (on ?x - tile ?y - pos)
    )
    (:functions
        (tile_given_pos ?x - pos) - tile
        (empty_space) - pos
    )
    (:action move
        :parameters (?x - pos ?y - pos ?tile - tile) ;;given a tile position, move it to the empty space
        :precondition (and
            (adj ?x ?y) 
            (on ?tile ?x)
            (on empty_tile ?y)
        )
        :effect (and 
            ;;swap the tile and the empty space
            (on ?tile ?y)(not (on ?tile ?x))
            (on empty_tile ?x)(not (on empty_tile ?y))
        )
    )
)
    