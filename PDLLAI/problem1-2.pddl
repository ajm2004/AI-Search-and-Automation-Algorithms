; WE ARE BUILDING TWO BASES,
; EACH AT L4 AND L5.
; THEN WE NEED TO TURN ON THE SONAR ARRAY.



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


(define (problem ConstructBaseAndSonar)
    (:domain domain1)

    (:objects
        kg 
        kc1 kc2 kc3
        kb1 kb2 kb3 kb4
        s1 s2 s3 s4
        l l1 l2 l3 l4 l5 
        p1 p2 p3 p4
        e1 e2 e3 e4 e5
        i1
        sk ec 
    )

    (:init
        (sub s1)
        (sub s2)
        (sub s3)
        (sub s4)

        (location l)
        (location l1)
        (location l2)
        (location l3)
        (location l4)
        (location l5)

        (pilot p1)
        (pilot p2)
        (pilot p3)
        (pilot p4)
        (engineer e1)
        (engineer e2)
        (engineer e3)
        (engineer e4)
        (scientist i1)

        (kit kg)
        (kit kc1)

        (kit kb1)
        (kit kb2)
        (kit kb3)
        (kit kb4)

        (structure_kit sk)
        (energy_cable ec)
 
        (not(protected l1))
        (not(protected l2))
        (not(protected l4))
        (not(protected l5))

        (shield_on s1)
        (shield_on s2)
        (shield_on s3)
        (shield_on s4)
        (not(kraken_at l1))
        (not(kraken_at l2))
        (not(kraken_at l4))
        (not(kraken_at l5))



        (kit_is kg sk)
        (kit_is kc1 ec)
        (kit_is kc2 ec)
        (kit_is kc3 ec)

        (kit_is kb1 sk)
        (kit_is kb2 sk)
        (kit_is kb3 sk)
        (kit_is kb4 sk)
        

        (land_at l)

        (cmd_at l1)
        (shallow_water_at l1)

        (shallow_water_at l2)

        (land_at l3)
 
        (deep_water_at l4)

        (deep_water_at l5)

        
        (adjacent l l1)
        (adjacent l1 l)
        (adjacent l1 l2)
        (adjacent l2 l1)

        (adjacent l2 l3)
        (adjacent l3 l2)
        
        (adjacent l2 l4)
        (adjacent l4 l2)

        (adjacent l2 l5)
        (adjacent l5 l2)

        (at e1 l1)
        (at e2 l1)

        (at e3 l1)
        (at e4 l1)

        (at i1 l1)

        (at s1 l1)
        (at s2 l1)
        (at s3 l1)
        (at s4 l1)

        (in p1 s1)
        (in p2 s2)
        (in p3 s3)
        (in p4 s4)
        

        (at kg l1)
        (at kc1 l1)
        (at kc2 l1)
        (at kc3 l1)
        (at kb1 l1)
        (at kb2 l1)
        (at kb3 l1)
        (at kb4 l1)

        
    )

    (:goal
        (and
            (generator_at l2)
            (cabe_at l4)
            (cabe_at l5)
            (base_at l4)
            (base_at l5)
            (sonar_on)
        )
    )
)