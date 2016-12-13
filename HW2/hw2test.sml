use "hw2.sml";

val a0 = all_except_option("hi",[]) = NONE
val a1 = all_except_option("hi",["hi"]) = SOME([])
val a2 = all_except_option("hi",["bye"]) = NONE
