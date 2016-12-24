(*-----------*)
(*----HW3----*)
(*-----------*)

exception NoAnswer

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
fun longest_string3 xs =
  List.foldl (fn (x,y) => if String.size x > String.size y then x else y) "" xs       
fun longest_string4 xs =
  List.foldl (fn (x,y) => if String.size x >= String.size y then x else y) "" xs

fun f x y = fn (x,y) => if String.size x > String.size y then x else y
fun longest_string_helper f xs = List.foldl f "" xs

(*-5-*)
fun longest_capitalized xs = (longest_string1 o only_capitals) xs

					    