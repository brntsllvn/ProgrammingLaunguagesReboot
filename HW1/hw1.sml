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

(*----*)
(* #2 *)
(*----*)		      

fun number_in_month(dates : (int * int * int) list, month : int) : int =

  let
      fun beg_of_next_month(date : (int * int * int)) : (int * int * int) =
	let
	    val year = #1 date
	in
	    if month < 12 then (year,month+1,1)
	    else (year+1,1,1)
	end

      fun end_of_previous_month(date : (int * int * int)) : (int * int * int) =
	let
	    val year = #1 date   
	in
	    if month = 1 then (year-1,12,31)
	    else if month = 2 then (year,month-1,31)
	    else if month = 3 then (year,month-1,28)
	    else if month = 4 then (year,month-1,31)
	    else if month = 5 then (year,month-1,30)
	    else if month = 6 then (year,month-1,31)
	    else if month = 7 then (year,month-1,30)
	    else if month = 8 then (year,month-1,31)
	    else if month = 9 then (year,month-1,31)
	    else if month = 10 then (year,month-1,30)
	    else if month = 11 then (year,month-1,31)
	    else (year,month-1,31)
	end
	    
  in
      if null dates then 0 else	    

      let	  
	  val date = hd dates
	  val beg_next_month = beg_of_next_month(date)
	  val end_prev_month = end_of_previous_month(date)
	  val date_befor_beg_next_month = is_older(date,beg_next_month)
	  val date_after_end_prev_month = is_older(end_prev_month,date)
      in
	  (*
	  print ("----------" ^ "\n");
	  print (Int.toString(#1 date) ^ " " ^
		 Int.toString(#2 date) ^ " " ^
		 Int.toString(#3 date) ^ " " ^
		 "\n");
	  print (Int.toString(#1 end_prev_month) ^ " " ^
		 Int.toString(#2 end_prev_month) ^ " " ^
		 Int.toString(#3 end_prev_month) ^ " " ^
		 "\n");
	  print (Int.toString(#1 beg_next_month) ^ " " ^
		 Int.toString(#2 beg_next_month) ^ " " ^
		 Int.toString(#3 beg_next_month) ^ " " ^
		 "\n");

	  print (Bool.toString(date_befor_beg_next_month) ^ "\n");
	  print (Bool.toString(date_after_end_prev_month) ^ "\n");
	  *)
	  
	  if date_befor_beg_next_month andalso date_after_end_prev_month
	  then 1 + number_in_month(tl dates,month)
	  else number_in_month(tl dates,month)
      end
  end
      

  
  
  
