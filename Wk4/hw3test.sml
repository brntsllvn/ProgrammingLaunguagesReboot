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
val t5 = only_capitals ["All","Bee","cee"] = ["All","Bee"]
					   
(*					      
val test2 = longest_string1 ["A","bc","C"] = "bc"

val test3 = longest_string2 ["A","bc","C"] = "bc"

val test4a = longest_string3 ["A","bc","C"] = "bc"

val test4b = longest_string4 ["A","B","C"] = "C"

val test5 = longest_capitalized ["A","bc","C"] = "A"

val test6 = rev_string "abc" = "cba"

val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4

val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE

val test9a = count_wildcards Wildcard = 1

val test9b = count_wild_and_variable_lengths (Variable("a")) = 1

val test9c = count_some_var ("x", Variable("x")) = 1

val test10 = check_pat (Variable("x")) = true

val test11 = match (Const(1), UnitP) = NONE

val test12 = first_match Unit [UnitP] = SOME []
*)
