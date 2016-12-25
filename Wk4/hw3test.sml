use "hw3.sml";

print("---1---" ^ "\n");
val sub1 = String.sub ("hello",0) = #"h"
val sub2 = String.sub ("hello",1) = #"e"
val upp1 = Char.isUpper #"h" = false
val upp2 = Char.isUpper #"H" = true
val sup1 = Char.isUpper(String.sub ("b",0)) = false
val sup2 = Char.isUpper(String.sub ("B",0)) = true
val myf1 = fn x => Char.isUpper(String.sub(x,0))
val res1 = myf1 "B" = true
val res2 = myf1 "b" = false					  
val t1 = only_capitals [] = []
val t2 = only_capitals ["b"] = []
val t3 = only_capitals ["B","b"] = ["B"]
val t4 = only_capitals ["b","b"] = []
val tp = only_capitals ["A","B","C"] = ["A","B","C"]
val t5 = only_capitals ["All","Bee","cee"] = ["All","Bee"];

print("---2---" ^ "\n");
val p2_1 = longest_string1 [] = ""
val p2_2 = longest_string1 ["b"] = "b"
val p2_3 = longest_string1 ["b","c"] = "b"
val p2_4 = longest_string1 ["b","cd"] = "cd"
val p2_5 = longest_string1 ["b","cd","dc","a"] = "cd"
val pp__ = longest_string1 ["A","bc","C"] = "bc";

print("---3---" ^ "\n");
val p3_1 = longest_string2 [] = ""
val p3_2 = longest_string2 ["b"] = "b"
val p3_3 = longest_string2 ["b","c"] = "c"
val p3_4 = longest_string2 ["b","cd"] = "cd"
val p3_5 = longest_string2 ["b","cd","dc","a"] = "dc"
val pp__ = longest_string2 ["A","bc","C"] = "bc";

print("---4---" ^ "\n");
val lsh   = longest_string_helper;
val ls3   = longest_string3
val ls4   = longest_string4
val ls3_0 = longest_string3 [] = ""
val ls3_1 = longest_string3 ["b","cd","dc","a"] = "cd"
val ls4_0 = longest_string4 [] = ""
val ls4_1 = longest_string4 ["b","cd","dc","a"] = "dc";

print("---5---" ^ "\n");
val p5_1 = longest_capitalized [] = ""
val p5_2 = longest_capitalized ["b"] = ""
val p5_3 = longest_capitalized ["B"] = "B"
val p5_4 = longest_capitalized ["B","c"] = "B"
val p5_5 = longest_capitalized ["B","C"] = "B"
val p5_6 = longest_capitalized ["B","CD","Dc","A"] = "CD";
val p5_7 = longest_capitalized ["A","bc","C"] = "A";

print("---6---" ^ "\n");
val ex1 = String.explode "abc" = [#"a",#"b",#"c"]
val lr1 = List.rev [#"a",#"b"] = [#"b",#"a"]
val p6_1 = rev_string "" = ""
val p6_2 = rev_string "a" = "a"
val p6_3 = rev_string "ab" = "ba"
val p6_4 = rev_string "abc" = "cba";

print("---7---" ^ "\n");
(*val p7_5 = first_answer (fn x => if x > 3 then SOME x else NONE) []*)
(*val p7_5 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3]*)
val p7_5 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4;

print("---x---" ^ "\n");
fun div_by_zero x = x div 0;
val oops = (div_by_zero 5 handle _ => ~5) = ~5;

print("---8---" ^ "\n");
fun f x = if x = 1 then SOME [x] else NONE
val p8_1 = all_answers f [] = SOME []
val p8_2 = all_answers f [1] = SOME [1]
val p8_3 = all_answers f [2] = NONE
val p8_4 = all_answers f [1,2] = NONE
val p8_5 = all_answers f [1,1] = SOME [1,1]
val p8_6 = all_answers f [1,1,2] = NONE
val p8_7 = all_answers f [2,3,4,5,6,7] = NONE;

print("---9---" ^ "\n");				       

				       (*


val test9a = count_wildcards Wildcard = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_some_var ("x", Variable("x")) = 1

val test10 = check_pat (Variable("x")) = true

val test11 = match (Const(1), UnitP) = NONE

val test12 = first_match Unit [UnitP] = SOME []
*)
