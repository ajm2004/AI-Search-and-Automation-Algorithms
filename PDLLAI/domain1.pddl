

(define (domain domain1)
    (:requirements
        :strips
        :negative-preconditions :disjunctive-preconditions
        :equality    
    )

    (:predicates
        ;Sub related predicates
        (sub ?s)
        (shield_on ?s)
        (full ?s)
        (full_load ?s)
        
        ;location related predicates
        (land_at ?l)
        (shallow_water_at ?l)
        (deep_water_at ?l)
        (location ?l)
        (cmd_at ?l)
        (generator_at ?l)
        (cabe_at ?l)
        (base_at ?l)
        (protected ?l)
        (kraken_at ?l)
        (surveyed ?l)
        
        ;people related predicates
        (pilot ?p)
        (engineer ?e)
        (scientist ?i)
        
        ;kits related predicates
        (kit ?k)
        (structure_kit ?g)
        (energy_cable ?o)
        
        ;Kit type predicate
        (kit_is ?k ?x)
        
        ;Basic Predicates
        (sonar_on)
        (tranfered_research ?l)
        (analyzed_research ?l)
        (researched ?l)

        ;Basic function related to location/types
        (at  ?x ?l)
        (in  ?p ?v)
        (adjacent ?l1 ?l2)
)

    ; Action to turn on the sonar array when two bases operational.
    (:action on_sonar_array
        :parameters (?l1 ?l2 ?e1 ?e2)
        :precondition (and 
            (not(= ?l1 ?l2))
            (location ?l1)
            (location ?l2)
            (base_at ?l1)
            (base_at ?l2)
            (not(= ?e1 ?e2))
            (engineer ?e1)
            (engineer ?e2)
            (at ?e1 ?l1)
            (at ?e2 ?l2)
        )
        :effect (and 
            (sonar_on)
        )
    )


    ; Action to load kits
    (:action load
        :parameters 
            (?k ?s ?l ?e)
        :precondition
            (and
                (kit ?k)
                (sub ?s)
                (location ?l)
                (engineer ?e)
                (or(cmd_at ?l)(base_at ?l))
                (at ?e ?l)
		        (at ?s ?l)
                (at ?k ?l)
                (not (full_load ?s))
            )
        :effect
            (and
                (in ?k ?s)
                (not (at ?k ?l))
                (full_load ?s)
            )
    )

    
    ; Action to unload kits
    (:action unload
        :parameters
            (?k ?s ?l ?e)
        :precondition
            (and
                (kit ?k)
                (sub ?s)
                (location ?l)
                (engineer ?e)
                (or(cmd_at ?l)(base_at ?l))
                ;(loc ?l ?c)
                (at ?e ?l)
		        (at ?s ?l)
                (in ?k ?s)
            )
        :effect
            (and
                (at ?k ?l)
                (not (in ?k ?s))
                (not (full_load ?s))
            )
    )

    
    ; Action to move the sub
    (:action move
        :parameters
            (?s ?l1 ?l2 ?p)
        :precondition
            (and
                (sub ?s)
                (pilot ?p)
                (location ?l1)
                (location ?l2)
                (adjacent ?l1 ?l2)
		        (at ?s ?l1)
		        (in ?p ?s)
		        (or(shallow_water_at ?l1) (deep_water_at ?l1))
		        (or(shallow_water_at ?l2) (deep_water_at ?l2))
		        (or (not (kraken_at ?l2))(not (kraken_at ?l1))(shield_on ?s)(sonar_on))
            )
    
        :effect
            (and
                (at ?s ?l2)
                (not (at ?s ?l1))
            )
    )

    
    ; Action to survey the location
    (:action survey
        :parameters (?s ?l ?p ?i)
        :precondition (and 
            (sub ?s)
            (location ?l)
            (pilot ?p)
            (scientist ?i)
            (in  ?p ?s)
            (in  ?i ?s)
            (at  ?s ?l)
        )
        :effect (and 
            (surveyed ?l)
        )
    )
    

    ; Action to intensive survey and research the location
    (:action int_research
        :parameters (?s ?l ?p ?i)
        :precondition (and 
            (sub ?s)
            (location ?l)
            (pilot ?p)
            (scientist ?i)
            (in  ?p ?s)
            (in  ?i ?s)
            (at  ?s ?l)
        )
        :effect (and 
            (researched ?l)
        )
    )

    
    ; Action to construct tidal generator
    (:action tg_construct
        :parameters (?s ?l1 ?l2 ?p ?e ?k ?g)
        :precondition (and 
            (sub ?s)
            (location ?l1)
            (location ?l2)
            (pilot ?p)
            (engineer ?e)
            (kit ?k)
            (structure_kit ?g)
            (surveyed ?l2)
            (not(protected ?l2))
            (not(kraken_at ?l2))


            (kit_is ?k ?g)
            (land_at ?l1)
            (shallow_water_at ?l2)
            (adjacent ?l1 ?l2)
            (at  ?s ?l2)
            (in  ?p ?s)
            (in  ?e ?s)
            (in  ?k ?s)
        )
        :effect (and 
            (not (in ?k ?s))
            (not (full_load ?s))
            (generator_at ?l2)
        )
    )

    
    ; Action to instsall energy cable
    (:action offc_construct
        :parameters (?s ?l1 ?l2 ?p ?e ?k ?o)
        :precondition (and 
            (sub ?s)
            (location ?l1)
            (location ?l2)
            (pilot ?p)
            (engineer ?e)
            (kit ?k)
            (energy_cable ?o)
            (generator_at ?l1)            
            (surveyed ?l2)
            (not(protected ?l2))
            (not(kraken_at ?l2))

            (kit_is ?k ?o)
            (deep_water_at ?l2)
            (generator_at ?l1)
            (adjacent ?l1 ?l2)
            (at  ?s ?l2)
            (in  ?p ?s)
            (in  ?e ?s)
            (in  ?k ?s)
        )
        :effect (and 
            (cabe_at ?l2)
        )
    )
    

    ; Action to build a base
    (:action base_construct
        :parameters (?s1 ?s2 ?l2 ?p1 ?p2 ?e1 ?e2 ?k1 ?k2 ?g)
        :precondition (and 
            (not (= ?s1 ?s2))
            (sub ?s1)
            (sub ?s2)
            (location ?l2)
            (pilot ?p1)
            (pilot ?p2)
            (engineer ?e1)
            (engineer ?e2)
            (kit ?k1)
            (kit ?k2)
            (structure_kit ?g)
            (surveyed ?l2)
            (not(protected ?l2))
            (not(kraken_at ?l2))

            (kit_is ?k1 ?g)
            (kit_is ?k2 ?g)
            (deep_water_at ?l2)
            (cabe_at ?l2)
            
            (in ?p1 ?s1)
            (in ?e1 ?s1)
            (in ?k1 ?s1)
            (at ?s1 ?l2)

            (in ?p2 ?s2)
            (in ?e2 ?s2)
            (in ?k2 ?s2)
            (at ?s2 ?l2)
        )
        :effect (and 
            (not (in ?k1 ?s1))
            (not (in ?k2 ?s2))
            (not (full_load ?s1))
            (not (full_load ?s2))
            (base_at ?l2)
        )
    )

    
    ; Action for a personall to board the sub
    (:action board_sub
        :parameters (?p ?s ?l)
        :precondition (and 
            (or(engineer ?p) (scientist ?p))
            (sub ?s)
            (location ?l)
            (or(cmd_at ?l)(base_at ?l))
            (at ?p ?l)
            (at ?s ?l)
            (not(full ?s))
        )
        :effect (and
            (not(at ?p ?l))
            (in ?p ?s)
            (full ?s)
        )
    )

    
    ; Action for a personall to deboard the sub
    (:action leave_sub
        :parameters (?p ?s ?l)
        :precondition (and 
            (or(engineer ?p) (scientist ?p))
            (sub ?s)
            (location ?l)
            (or(cmd_at ?l)(base_at ?l))
            (at ?s ?l)
            (in ?p ?s)
        )
        :effect (and 
            (not (in ?p ?s))
            (at ?p ?l)
            (not(full ?s))
        )
    )

    
    ; Action to transfer research to the base from sub
    (:action transfer_research
        :parameters (?s ?l ?rl)
        :precondition (and 
            (location ?l)
            (location ?rl)
            (sub ?s)
            (base_at ?l)
            (at ?s ?l)
            (researched ?rl)
        )
        :effect (and 
            (tranfered_research ?rl)
        )
    )

    
    ; Action to analyze the research in base
    (:action analyze_research
        :parameters (?l ?i ?rl)
        :precondition (and
            (location ?l)
            (location ?rl)
            (base_at ?l)
            (scientist ?i)
            (at ?i ?l)
            (tranfered_research ?rl) 
        )
        :effect (and 
            (analyzed_research ?rl)
        )
    )
    

    ; Action to activate the submarine shield
    (:action activate_shield
        :parameters (?s ?p ?l)
        :precondition (and 
            (sub ?s)
            (location ?l)
            (kraken_at ?l)
            (pilot ?p)
            (in ?p ?s)
            (not(sonar_on))
        )
        :effect (and 
            (shield_on ?s)
            
        )
    )
)

    
    
    
    



