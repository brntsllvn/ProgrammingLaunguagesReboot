use "hw2.sml";

val a0 = all_except_option("hi",[]) = NONE
val a1 = all_except_option("hi",["hi"]) = SOME([])
val a2 = all_except_option("hi",["po"]) = NONE
val a3 = all_except_option("hi",["hi","po"]) = SOME(["po"])
val a4 = all_except_option("hi",["po","go"]) = NONE
val a5 = all_except_option("hi",["po","hi"]) = SOME(["po"])
val a6 = all_except_option("hi",["po","hi","be"]) = SOME(["be","po"])
val a7 = all_except_option("hi",["hi","po","be"]) = SOME(["be","po"]) 
val a8 = all_except_option("hi",["si","po","be"]) = NONE							
