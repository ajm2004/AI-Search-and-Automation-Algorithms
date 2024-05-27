; We are trying to analyze the intensive survey results of 
; previously unexplored location "L6".
; The krakens have shifted to new locations those 
; are L2, L3 and L4.

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

(define (problem ResearchL6)
    (:domain domain1)
    (:objects
        s1
        l l1 l2 l3 l4 l5 l6
        e3 e4
        i1
        p1
        b1
        b2
    )
    (:init
        (sub s1)
        (location l)
        (location l1)
        (location l2)
        (location l3)
        (location l4)
        (location l5)
        (location l6)
        
        (land_at l)
        (shallow_water_at l1)
        (shallow_water_at l2)
        (land_at l3)
        (deep_water_at l4)
        (deep_water_at l5)
        (deep_water_at l6)
        
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
        (adjacent l5 l6)
        (adjacent l6 l5)

        (kraken_at l2)
        (kraken_at l3)
        (kraken_at l4)

        (pilot p1)
        (scientist i1)

        (engineer e3)
        (engineer e4)

        (in p1 s1)
        (cmd_at l1)
        (base_at l4)
        (base_at l5)

        (at e3 l4)
        (at e4 l5)
        (at i1 l1)
        (at s1 l1)
    )
    (:goal
        (and
            (sonar_on)
            (analyzed_research l6)
        )
    )
)
