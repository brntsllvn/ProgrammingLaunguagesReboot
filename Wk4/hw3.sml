(*-----------*)
(*----HW3----*)
(*-----------*)

exception NoAnswer

(*-1-*)
fun only_capitals xs =
  List.filter (fn x => Char.isUpper(String.sub(x,0))) xs

(*-2-*)
fun longest_string1 xs =
  List.foldl (fn (x,y) => if String.size x > String.size y then x else y) "" xs

(*-3-*)
fun longest_string2 xs =
  List.foldl (fn (x,y) => if String.size x >= String.size y then x else y) "" xs

(*-4-*)
fun f(x,y) = x > y
fun g(x,y) = x >= y
fun longest_string_helper f xs =
  List.foldl (fn (x,y) => if f(String.size x, String.size y) then x else y) "" xs

val longest_string3 = longest_string_helper f
val longest_string4 = longest_string_helper g
					    
(*-5-*)
fun longest_capitalized xs = (longest_string1 o only_capitals) xs

(*-6-*)
fun rev_string str = (String.implode o List.rev o String.explode) str
					    
(*-7-*)
fun first_answer f xs =
  case xs of
      [] => raise NoAnswer
    | x::xs' => case f x of
		    NONE => first_answer f xs'
		  | SOME x => x 
				  
(*-8-*)
fun all_answers f xs =
  let
      fun end_or_append xs acc =
	case xs of
	    [] => acc
	  | x::xs' => case f x of
			  NONE => acc
			| SOME [x] => [x] @ end_or_append xs' acc
      val result = end_or_append xs []
  in
      if length result <> length xs then NONE else SOME result
  end;


datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(*-9a-*)
fun count_wildcards p =
  g (fn () => 1) (fn x => 0) p

(*-9b-*)
fun count_wild_and_variable_lengths p =
  g (fn () => 1) (fn x => String.size x) p

(*-9c-*)
fun count_some_var(str,p) =
  g (fn () => 0) (fn x => if x = str then 1 else 0) p

(*-10-*)
fun get_variable_strngs p =
  case p of
      Variable x => [x]
    | TupleP ps => List.foldl (fn (p,acc) => (get_variable_strngs p) @ acc) [] ps
    | ConstructorP(_,p) => get_variable_strngs p
    | _ => [] 
         
fun r xs =
  let
      fun count_repeats findme listOStrings =
	case listOStrings of
	    [] => 0
	  | x::xs' => if x = findme
		      then 1 + count_repeats findme xs'
		      else count_repeats findme xs'

      fun loop listOStrings =
	case listOStrings of
	    [] => false
	  | x::[] => false 
	  | x::xs' => if count_repeats x xs > 1
		      then true
		      else false orelse loop xs'			 
  in
      loop xs
  end
      

	       
(*
fun check_pat p =
  let
      fun get_variable_strings p =
	["hi","bye"]
      fun contains_repeats xs =
	true
  in
      true
  end
      
*)


		      
(*-11-*)
(*-12-*)
(*fun first_match v [] = SOME []  *)  
