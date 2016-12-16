use "hw2.sml";

val a0 = all_except_option("hi",[]) = NONE
val a1 = all_except_option("hi",["hi"]) = SOME([])
val a2 = all_except_option("hi",["po"]) = NONE
val a3 = all_except_option("hi",["hi","po"]) = SOME(["po"])
val a4 = all_except_option("hi",["po","go"]) = NONE
val a5 = all_except_option("hi",["po","hi"]) = SOME(["po"])
val a6 = all_except_option("hi",["po","hi","be"]) = SOME(["be","po"])
val a7 = all_except_option("hi",["hi","po","be"]) = SOME(["be","po"]) 
val a8 = all_except_option("hi",["si","po","be"]) = NONE;

print("-----------------------" ^ "\n");

val b0 = get_substitutions1([],"B") = []
val b1 = get_substitutions1([[]],"B") = []
val b2 = get_substitutions1([["B"]],"B") = []
val b3 = get_substitutions1([["B","Brent"]],"B") = ["Brent"]
val b4 = get_substitutions1([["B","Brent"],["ace","dog"],["Brnt","B"]],"B") = ["Brent","Brnt"]
val b5 = get_substitutions1([["B"],["ace"]],"B") = [];
val b6 = get_substitutions1([["B","Brent","bert","bill"]],"B") = ["bill","bert","Brent"];

print("-----------------------" ^ "\n");

val c0 = get_substitutions2([],"B") = []
val c1 = get_substitutions2([[]],"B") = []
val c2 = get_substitutions2([["B"]],"B") = []
val c3 = get_substitutions2([["B","Brent"]],"B") = ["Brent"]
val c4 = get_substitutions2([["B","Brent"],["ace","dog"],["Brnt","B"]],"B") = ["Brnt","Brent"]
val c5 = get_substitutions2([["B"],["ace"]],"B") = []
val c6 = get_substitutions2([["B","Brent","bert","bill"]],"B") = ["bill","bert","Brent"]; 

print("-----------------------" ^ "\n");

val betsy = {first="betsy",middle="s",last="sullivan"}
val d0 = similar_names([],betsy) = [betsy]
val d1 = similar_names([[]],betsy) = [betsy]
val d2 = similar_names([["betsy"]],betsy) = [betsy]
val d3 = similar_names([["betsy","b"]],betsy) = [betsy,{first="b",middle="s",last="sullivan"}]
val d4 = similar_names([["betsy","b"],["betsy","betty"]],betsy) =
	 [betsy,{first="b",middle="s",last="sullivan"},{first="betty",middle="s",last="sullivan"}]
val d5 = similar_names([["betsy","b"],["betsy","betty"],["fred","bob"]],betsy) =
	 [betsy,{first="b",middle="s",last="sullivan"},{first="betty",middle="s",last="sullivan"}]
val d6 = similar_names([["betsy","b"],["betsy","betty","bee"],["fred","bob"]],betsy) =
	 [betsy,{first="b",middle="s",last="sullivan"},{first="betty",middle="s",last="sullivan"},{first="bee",middle="s",last="sullivan"}]
val d7 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
{first="Fred", middle="W", last="Smith"}) = [{first="Fred", last="Smith", middle="W"},
{first="Fredrick", last="Smith", middle="W"},
{first="Freddie", last="Smith", middle="W"},
{first="F", last="Smith", middle="W"}];


print("-------------------------------" ^ "\n");
print("Problem 2----------------------" ^ "\n");
print("-------------------------------" ^ "\n");

val a20 = card_color(Clubs,Jack) = Black
val a21 = card_color(Hearts,Jack) = Red
val a22 = card_color(Diamonds,Jack) = Red
val a23 = card_color(Spades,Jack) = Black
val a24 = card_color(Spades,Ace) = Black;

print("-------------------------------" ^ "\n");
				       
val b20 = card_value(Clubs,Jack) = 10
val b21 = card_value(Clubs,Num 3) = 3
val b22 = card_value(Diamonds,Num 8) = 8
val b23 = card_value(Spades,Ace) = 11
val b24 = card_value(Hearts,King) = 10
val b25 = card_value(Hearts,Queen) = 10;

print("-------------------------------" ^ "\n");

(*
exception SomeException
val myJack = (Spades,Jack)
val c20 = remove_card([],myJack,SomeException) = []
val c21 = remove_card([myJack],myJack,SomeException) = []
val c22 = remove_card([myJack,(Hearts,King)],myJack,SomeException) = [(Hearts,King)]
val c23 = remove_card([myJack,myJack],myJack,SomeException) = [myJack]
val c24 = remove_card([(Hearts,King)],myJack,SomeException) = []
val c25 = remove_card([myJack,(Hearts,Ace),(Spades,Ace)],myJack,SomeException) = [(Hearts,Ace),(Spades,Ace)]
*)
val blkJack = (Spades,Jack)
val redKing = (Hearts,King)
val d20 = all_same_color([]) = true
val d21 = all_same_color([blkJack]) = true
val d22 = all_same_color([blkJack,blkJack]) = true
val d23 = all_same_color([blkJack,redKing]) = false
val d24 = all_same_color([blkJack,blkJack,blkJack]) = true
val d25 = all_same_color([blkJack,redKing,redKing,blkJack,blkJack]) = false
val d26 = all_same_color([redKing,redKing]) = true
val d27 = all_same_color([(Diamonds,Num 5)]) = true;
val d28 = all_same_color([(Diamonds,Num 5),(Hearts,Queen)]) = true;
val d29 = all_same_color([(Diamonds,Num 5),(Hearts,Queen),redKing]) = true;

print("-------------------------------" ^ "\n");

val myAce = (Spades,Ace)
val myQueen = (Hearts,Queen)
val myKing = (Diamonds,King)
val myTwo = (Spades,Num 2)
val e20 = sum_cards([]) = 0
val e21 = sum_cards([myAce]) = 11
val e22 = sum_cards([myAce,myAce]) = 22
val e23 = sum_cards([myAce,myQueen,myTwo,myKing]) = 33;

print("-------------------------------" ^ "\n");

val sBlkAce = (Spades,Ace)
val sBlkKng = (Clubs,King)
val sBlkTwo = (Spades,Num 2)
val sRedJck = (Hearts,Jack)
val sRedFiv = (Diamonds,Num 5)
val sRedQen = (Hearts,Queen)

val f0 = score([],0) = 0
val f1 = score([sBlkAce],0) = 16
val f2 = score([sBlkAce],12) = 0
val f3 = score([sBlkAce,sBlkTwo],0) = 19
val f4 = score([sBlkAce,sBlkTwo],13) = 0
val f5 = score([sBlkKng,sRedJck],0) = 60 
val f6 = score([sBlkKng,sRedJck],20) = 0
val f7 = score([sRedFiv,sRedQen,sRedJck],0) = 37
val f8 = score([sRedFiv,sRedQen,sRedJck],25) = 0
val f9 = score([sRedFiv,sRedQen,sBlkTwo],0) = 51;
val f10 = score([(Hearts,Num 2),(Clubs,Num 4)],10) = 4;

print("-------------------------------" ^ "\n");

val 

(* deck, moves, goal *)
val g0 = officiate([],[],0) = 0
val g1 = officiate([(Spades,King)],[],0) = 0
val g2 = officiate([(Spades,King)],[Draw],0) =  
