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
{first="F", last="Smith", middle="W"}]
