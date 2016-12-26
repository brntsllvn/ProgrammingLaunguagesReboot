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
val p7_5 = (first_answer (fn x => if x > 3 then SOME x else NONE) [] handle _ => 0) = 0; 
val p7_5 = (first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3] handle _ => 0) = 0;
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

print("---9a---" ^ "\n");
val p9a_1 = count_wildcards Wildcard = 1
val p9a_2 = count_wildcards (Variable "b") = 0
val p9a_3 = count_wildcards UnitP = 0
val p9a_4 = count_wildcards (ConstP 2) = 0
val p9a_5 = count_wildcards (TupleP [Wildcard]) = 1
val p9a_6 = count_wildcards (TupleP [Wildcard,Wildcard]) = 2
val p9a_7 = count_wildcards (TupleP [TupleP [Wildcard,Wildcard],Wildcard]) = 3
val p9a_8 = count_wildcards (TupleP [TupleP [Wildcard,UnitP],Wildcard]) = 2
val p9a_9 = count_wildcards (ConstructorP ("hi",Wildcard)) = 1
val p9a_0 = count_wildcards (ConstructorP ("hi",TupleP [Wildcard])) = 1;

print("---9b---" ^ "\n");
count_wild_and_variable_lengths;
val p9b_1 = count_wild_and_variable_lengths (Variable "a") = 1
val p9b_2 = count_wild_and_variable_lengths (Variable "abc") = 3
val p9b_3 = count_wild_and_variable_lengths Wildcard = 1
val p9b_4 = count_wild_and_variable_lengths (TupleP [Variable "abc"]) = 3
val p9b_5 = count_wild_and_variable_lengths (TupleP [Wildcard]) = 1
val p9b_6 = count_wild_and_variable_lengths (TupleP [Variable "abc",Wildcard]) = 4
val p9b_7 = count_wild_and_variable_lengths (ConstructorP ("hi",Variable "abc")) = 3
val p9b_8 = count_wild_and_variable_lengths (ConstructorP ("hi",TupleP [Variable "abc",Wildcard])) = 4;	       

print("---9c---" ^ "\n");
count_some_var;
val p9c_1 = count_some_var("a",Variable "a") = 1 
val p9c_2 = count_some_var("a",Variable "b") = 0
val p9c_3 = count_some_var("abc",Variable "abc") = 1
val p9c_4 = count_some_var("a",TupleP [Variable "a",Variable "a"]) = 2
val p9c_5 = count_some_var("abc",TupleP [Variable "abc",Variable "a"]) = 1
val p9c_6 = count_some_var("abc",TupleP [TupleP [Variable "abc",Wildcard],Variable "a"]) = 1
val p9c_7 = count_some_var("abc",TupleP [Variable "abc",ConstructorP("hi",Variable "abc")]) = 2;

print("---10---" ^ "\n");
(*
print("---hlp1---" ^ "\n");
val hlp1_0 = get_variable_strngs Wildcard  = []
val hlp1_1 = get_variable_strngs (Variable "hi") = ["hi"]
val hlp1_2 = get_variable_strngs (TupleP [Variable "hi"]) = ["hi"]
val hlp1_3 = get_variable_strngs (TupleP [Variable "hi",Variable "hi"]) = ["hi","hi"]
val hlp1_4 = get_variable_strngs (TupleP [Variable "hi",TupleP [Variable "hi"]]) = ["hi","hi"]
val hlp1_5 = get_variable_strngs (ConstructorP("abc",Variable "hi")) = ["hi"] 
val hlp1_6 = get_variable_strngs (ConstructorP("abc",TupleP [Variable "hi"])) = ["hi"]
val hlp1_7 = get_variable_strngs (ConstructorP("abc",TupleP [Variable "hi",ConstructorP("bye",Variable "dog")])) = ["dog","hi"]
val hlp1_8 = get_variable_strngs UnitP = []
val hlp1_9 = get_variable_strngs (ConstP 4) = [] 
val hlp1_10 = get_variable_strngs (ConstructorP("abc",TupleP [(ConstP 5),ConstructorP("bye",Variable "dog")])) = ["dog"]
val hlp1_11 = get_variable_strngs (ConstructorP("abc",TupleP [UnitP,ConstructorP("bye",Variable "dog")])) = ["dog"];
print("---hlp2---" ^ "\n");
r;
val rep_1 = r [] = false
val rep_2 = r ["hi"] = false
val rep_3 = r ["hi","hi"] = true
val rep_4 = r ["hi","po"] = false
val rep_5 = r ["hi","po","hi"] = true;
*)
check_pat;
val p10_1 = check_pat Wildcard = false
val p10_2 = check_pat (Variable "hi") = false
val p10_3 = check_pat UnitP = false
val p10_4 = check_pat (ConstP 3) = false
val p10_5 = check_pat (TupleP [Variable "hi"]) = false
val p10_6 = check_pat (TupleP [Variable "hi",Variable "hi"]) = true
val p10_7 = check_pat (ConstructorP("a",Variable "hi")) = false
val p10_8 = check_pat (TupleP [Variable "hi",TupleP [Variable "hi"]]) = true
val p10_9 = check_pat (ConstructorP("a",TupleP [Variable "hi",UnitP,ConstructorP("a",Variable "hi")])) = true;
									    
print("---11---" ^ "\n");
match;
val p11_1 = match (Const 1, Wildcard) = SOME []
val p11_2 = match (Unit, Wildcard) = SOME []
val p11_3 = match (Tuple [Const 1], Wildcard) = SOME []
val p11_4 = match (Constructor ("hi",Unit), Wildcard) = SOME []
 
val p11_5 = match (Const 1, UnitP) = NONE
val p11_6 = match (Unit, UnitP) = SOME []
val p11_7 = match (Tuple [Const 1], UnitP) = NONE
val p11_8 = match (Constructor ("hi",Unit), UnitP) = NONE

val p11_9  = match (Const 1, Variable "hi") = SOME [(Variable "hi",Const 1)]
val p11_10 = match (Unit, Variable "hi") = SOME [(Variable "hi",Unit)] 		     
val p11_11 = match (Tuple [Const 1], Variable "hi") = SOME [(Variable "hi",Tuple [Const 1])]
val p11_12 = match (Constructor("a",Unit), Variable "hi") = SOME [(Variable "hi",Constructor("a",Unit))]

val p11_13 = match (Const 1, ConstP 1) = SOME []
val p11_14 = match (Unit, ConstP 1) = NONE
val p11_15 = match (Tuple [Const 1], ConstP 1) = NONE
val p11_16 = match (Constructor("a",Unit), ConstP 1) = NONE

val p11_17 = match (Const 1, TupleP [ConstP 1]) = NONE
val p11_18 = match (Unit, TupleP [ConstP 1]) = NONE
val p11_19 = match (Tuple [Const 1], TupleP [ConstP 1]) = SOME []
val p11_20 = match (Tuple [Const 1], TupleP [Variable "hi"]) = SOME[(Variable "hi", Const 1)]
val p11_21 = match (Constructor("a",Unit), TupleP [ConstP 1]) = NONE;

print("---12---" ^ "\n");			
first_match;
val p12_1 = first_match (Const 1) [ConstP 1] = SOME []
val test12 = first_match Unit [UnitP] = SOME []
