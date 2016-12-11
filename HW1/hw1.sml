(*----*)
(* #1 *)
(*----*)

fun is_older((year1 : int, month1 : int, day1 : int),
	     (year2 : int, month2 : int, day2 : int)) : bool  =
  if year1 > year2 then false
  else if year1 < year2 then true
  else
      if month1 > month2 then false
      else if month1 < month2 then true
      else day1 < day2
      
