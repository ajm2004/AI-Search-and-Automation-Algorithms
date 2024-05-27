;WE ARE TRYING TO LAY CABLES AT LOCATION L4
;BY BUILDING A TIDAL GENERATOR AT LOCATION L2


;NOTE
; 1.kg: kit generator 
; 2.kc1, kc2, kc3: kit cable
; 3.kb1, kb2, kb3, kb4: kit base 
; 
; s1,s2,s,s3,s4: Submarines (1 to 4)
; 
; l,l1,l2,l3,l4,l5: Locations (0:land and 1 to 5)
; 
; p1,p2,p3,p4: Pilots (1 to 4)
; e1,e2,e3,e4,e5: Engineers (1 to 5)
; i1: Scientist
; 
; sk: structural kit
; ec: energy cable kit
; 
; Location Details:
; l: Land
; l1: Command Centre 1 (Next To Land) & Shallow Water
; l2: Tidal Generator & Shallow Water 
; l3: land
; l4: Base 1 & Deep Water
; l5: Base 2 & Deep Water
; l6: Unexplored Deep Water


(define (problem ConstructTG)
    (:domain domain1)

    (:objects
        kg kc
        s1 
        l l1 l2 l3 l4 
        p1 
        e1 e2 
        i1
        sk ec 
    )

    (:init
        (sub s1)
        (location l)
        (location l1)
        (location l2)
        (location l3)
        (location l4)

        (pilot p1)
        (engineer e1)
        (engineer e2)
        (scientist i1)

        (kit kg)
        (kit kc)


        (structure_kit sk)
        (energy_cable ec)

        (not(protected l1))
        (not(protected l2))
        (not(protected l4))
        (shield_on s1)
        (not(kraken_at l1))
        (not(kraken_at l2))
        (not(kraken_at l4))


        (kit_is kg sk)
        (kit_is kc ec)


        (land_at l)

        (shallow_water_at l1)

        (shallow_water_at l2)

        (land_at l3)

        (deep_water_at l4)

        
        (adjacent l l1)
        (adjacent l1 l)
        (adjacent l1 l2)
        (adjacent l2 l1)
        (adjacent l2 l3)
        (adjacent l3 l2)
        
        (adjacent l2 l4)
        (adjacent l4 l2)
        

        (cmd_at l1)
        (at e2 l1)
        (at e1 l1)

        (at i1 l1)

        (at s1 l1)

        (in p1 s1)
        

        (at kg l1)
        (at kc l1)
        
    )

    (:goal
        (and
            (at s1 l4)
            (not(in kg s1))
            (generator_at l2)
            (not(in kc s1))
            (cabe_at l4)
        )
    )
)
