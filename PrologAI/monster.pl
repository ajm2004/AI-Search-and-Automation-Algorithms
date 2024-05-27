
% distinct(Goal) :-
%     findall(Goal, Goal, List),
%     list_to_set(List, Set),
%     member(Goal, Set).

%There are 5 kinds of monster types in the game.
basictype(ghost).
basictype(physchic).
basictype(fighting).
basictype(normal).
basictype(dark).

%There are 5 kinds of monsters in the game.
monster(annihilape,ghost).
monster(espathra,physchic).
monster(flamigo,fighting).
monster(lechonk,normal).
monster(mabosstiff,dark).

%There are multiple monster moves in the game.
%annihilape moves
move(lowkick,fighting).
move(shadowPunch,ghost).
move(rageFist,ghost).
move(bodySlam,normal).
%espathra moves
move(psyBeam,physchic).
move(quickAttack,normal).
%move(lowKick,fighting).
move(shadowBall,ghost).
%flamigo moves
%move(lowKick,fighting).
move(payback,dark).
move(megaKick,normal).
move(closeCombat,fighting).
%lechonk moves
%move(bodySlam,normal).
move(tackle,normal).
move(takeDown,normal).
move(zenHeadbutt,physchic).
%mabosstiff moves
move(snarl,dark).
move(lick,ghost).
move(bite,dark).
%move(bodySlam,normal).

%The monster have their special moves in the game.

monsterMove(annihilape,lowKick).
monsterMove(annihilape,shadowPunch).
monsterMove(annihilape,rageFist).
monsterMove(annihilape,bodySlam).

monsterMove(espathra,psyBeam).
monsterMove(espathra,quickAttack).
monsterMove(espathra,lowKick).
monsterMove(espathra,shadowBall).

monsterMove(flamigo,lowKick).
monsterMove(flamigo,payback).
monsterMove(flamigo,megaKick).
monsterMove(flamigo,closeCombat).

monsterMove(lechonk,bodySlam).
monsterMove(lechonk,tackle).
monsterMove(lechonk,takeDown).
monsterMove(lechonk,zenHeadbutt).

monsterMove(mabosstiff,snarl).
monsterMove(mabosstiff,lick).
monsterMove(mabosstiff,bite).
monsterMove(mabosstiff,bodySlam).

% Different move types have different effects on the monsters 
%Eg: physchic move is weak against physchic type monster.

typeEffectiveness(weak,physchic,phschic).
typeEffectiveness(strong,physchic,fighting).
typeEffectiveness(superweak,physchic,dark).
typeEffectiveness(ordinary,physchic,ghost).
typeEffectiveness(ordinary,physchic,normal).

typeEffectiveness(weak,fighting,physchic).
typeEffectiveness(ordinary,fighting,fighting).
typeEffectiveness(strong,fighting,dark).
typeEffectiveness(superweak,fighting,ghost).
typeEffectiveness(strong,fighting,normal).

typeEffectiveness(strong,dark,physchic).
typeEffectiveness(weak,dark,fighting).
typeEffectiveness(weak,dark,dark).
typeEffectiveness(strong,dark,ghost).
typeEffectiveness(ordinary,dark,normal).

typeEffectiveness(strong,ghost,physchic).
typeEffectiveness(ordinary,ghost,fighting).
typeEffectiveness(weak,ghost,dark).
typeEffectiveness(strong,ghost,ghost).
typeEffectiveness(superweak,ghost,normal).

typeEffectiveness(ordinary,normal,physchic).
typeEffectiveness(ordinary,normal,fighting).
typeEffectiveness(ordinary,normal,dark).
typeEffectiveness(superweak,normal,ghost).
typeEffectiveness(ordinary,normal,normal).

% Effectiveness Relationship
moreEffective(strong,ordinary).
moreEffective(ordinary,weak).
moreEffective(weak,superweak).

% Rule 1: transitive effectiveness information (to show strong is more effective than weak or superweak)
moreEffectiveThan(E1,E2):- moreEffective(E1,E2).
moreEffectiveThan(E1,E2):- moreEffective(E1,E),moreEffectiveThan(E,E2).

% Rule 2: Two monsters have a move of type t.
% Eg. annihilape has a move of type bodyslam. lechonk has a move of type bodyslam. Both are same move same type.
monsterMoveMatch(T,M1,M2,MV):- not(M1==M2), monsterMove(M1,MV), monsterMove(M2,MV), move(MV,T), M1\=M2.

/* 
Rule 3: Represent Idea that that move MV1 is more 
effective than move MV2 against monsters of type T. 
*/
moreEffectiveMoveType(MV1,MV2,T):- move(MV1,T1),move(MV2,T2),typeEffectiveness(E1,T1,T),typeEffectiveness(E2,T2,T),moreEffectiveThan(E1,E2). 

/* 
Rule 4: represent the idea that if
monster MO1 performs move MV1 against MO2, and monster MO2 performs move MV2 against MO1, then
MV1 is more effective than MV2
*/
moreEffectiveMove(MO1,MV1,MO2,MV2):-
    monster(MO1,T1),
    monster(MO2,T2),
    move(MV1,TV1),
    move(MV2,TV2),
    typeEffectiveness(E1,TV1,T2),
    typeEffectiveness(E2,TV2,T1),
    moreEffectiveThan(E1,E2).


