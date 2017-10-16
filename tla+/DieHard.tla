------------------------------ MODULE DieHard ------------------------------

EXTENDS Integers
VARIABLES small, big

TypeOK == /\ small \in 0..3
          /\ big   \in 0..5
          
Init == /\ small = 0
        /\ big   = 0

FillSmall == /\ small' = 3
             /\ big'   = big

FillBig == /\ big'   = 5
           /\ small' = small

EmptySmall == /\ small' = 0
              /\ big'   = big

EmptyBig == /\ big'   = 0
            /\ small' = small

SmallToBig == IF   big + small =< 5
              THEN /\ big'   = big + small
                   /\ small' = 0
              ELSE /\ big'   = 5
                   /\ small' = small - ( 5 - big )
                 
BigToSmall == IF   big + small =< 3
              THEN /\ big'   = 0
                   /\ small' = small + big
              ELSE /\ small' = 3
                   /\ big'   = small - ( 3 - big )

Next ==  \/ FillSmall
         \/ FillBig
         \/ EmptySmall
         \/ EmptyBig
         \/ SmallToBig
         \/ BigToSmall 

=============================================================================
\* Modification History
\* Last modified Mon Oct 16 23:02:18 CEST 2017 by ostera
\* Created Mon Oct 16 21:44:23 CEST 2017 by ostera
