(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

val is_older_0 = is_older ((1,1,1),(1,1,1)) = false
val is_older_1 = is_older ((1,2,3),(2,3,4)) = true
(* year *)
val is_older_2 = is_older ((1999,12,31),(1999,12,31)) = false
val is_older_3 = is_older ((1999,12,31),(2000,12,31)) = true		  
val is_older_4 = is_older ((2000,12,31),(1999,12,31)) = false
(* month *)							    
val is_older_5 = is_older ((1999,12,31),(1999,12,31)) = false
val is_older_6 = is_older ((1999,11,31),(1999,12,31)) = true
val is_older_7 = is_older ((1999,12,31),(1999,11,31)) = false
(* day *)						    
val is_older_8 = is_older ((1999,12,31),(1999,12,31)) = false
val is_older_9 = is_older ((1999,12,10),(1999,12,31)) = true
val is_older_a = is_older ((1999,12,31),(1999,12,10)) = false

val number_in_month_0 = number_in_month ([],1) = 0

val number_in_month_1 = number_in_month ([(1999,1,1)],1) = 1
val number_in_month_2 = number_in_month ([(1998,12,31)],1) = 0
val number_in_month_3 = number_in_month ([(1999,2,1)],1) = 0
							    
val number_in_month_4 = number_in_month ([(1999,1,1),(1999,1,1)],1) = 2
val number_in_month_5 = number_in_month ([(1998,12,31),(1999,2,1)],1) = 0
val number_in_month_6 = number_in_month ([(1998,1,31),(1999,2,1)],1) = 1
val number_in_month_7 = number_in_month ([(1776,1,31),(1999,1,1)],1) = 2

val number_in_month_8 = number_in_month ([(1999,1,1),(1776,1,1),(1986,1,1)],1) = 3
val number_in_month_9 = number_in_month ([(1999,12,31),(1999,2,1),(1999,1,1)],1) = 1										     		   
val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1


val number_in_months_0 = number_in_months([],[]) = 0

val number_in_months_1 = number_in_months([(1999,1,31)],[1]) = 1
val number_in_months_2 = number_in_months([(1999,2,31)],[1]) = 0

val number_in_months_3 = number_in_months([(1999,2,31)],[1,2]) = 1
val number_in_months_4 = number_in_months([(1999,1,31),(1999,2,31)],[1,2]) = 2
val number_in_months_5 = number_in_months([(1999,1,31),(1999,2,31)],[4,5]) = 0
								   
val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3


											   (*
val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]

val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3

val test9 = what_month 70 = 3

val test10 = month_range (31, 34) = [1,2,2,2]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
*)
