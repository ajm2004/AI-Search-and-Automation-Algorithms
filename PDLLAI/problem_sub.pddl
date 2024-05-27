;THIS IS A PROBLEM WHERE WE MOVE FROM POINT 1 TO POINT 2
;BUT THERE ARE KRAKEN ON THE WAY
;WE HAVE TO DROP OF A KIT AT L5 WHICH IS A BASE
;WE HAVE TO PICK UP A KIT AT L1 WHICH IS A Cmd Cntr.
;The krakens have shifted to new locations those 
;are L2, L3 and L4. Hence we turn on the sonar.


;NOTE
; 1.kg: kit generator 
; 2.kc1, kc2, kc3: kit cable
; 3.kb1, kb2, kb3, kb4: kit base 
; 
; s1,s2,s,s3,s4: Submarines (1 to 4)
; 
; l,l1,l2,l3,l4,l5: Locations (0:land and 1 to 5)
; 
; 1.p,p1,p2,p3,p4: Pilots (1 to 4)
; 2.e,e1,e2,e3,e4,e5: Engineers (1 to 5)
; 3.i1: Scientist
; 
; 1.sk: structural kit
; 2.ec: energy cable kit
; 
; Location Details:
; l: Land
; l1: Command Centre 1 (Next To Land) & Shallow Water
; l2: Tidal Generator & Shallow Water 
; l3: land
; l4: Base 1 & Deep Water
; l5: Base 2 & Deep Water
; l6: Unexplored Deep Water


(define (problem LoadMoving)
    (:domain domain1)
    (:objects
        k1 
        s1
        l l1 l2 l3 l4 l5
        e1 e2 e3 e4
        p
        b1
        b2
    )
    (:init
        (kit k1)
        (sub s1)
        (location l)
        (location l1)
        (location l2)
        (location l3)
        (location l4)
        (location l5)
        
        (land_at l)
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

        (kraken_at l2)
        (kraken_at l3)
        (kraken_at l4)

        (pilot p)
        (engineer e1)
        (engineer e2)
        (engineer e3)
        (engineer e4)
        (in p s1)
        (cmd_at l1)
        (base_at l4)
        (base_at l5)
        (at e1 l1)
        (at e2 l1)
        (at e3 l4)
        (at e4 l5)

        (at k1 l1)
        (at s1 l1)
    )
    (:goal
        (and
            
            (sonar_on)
            (at s1 l5)
            (at k1 l5)
        )
    )
)